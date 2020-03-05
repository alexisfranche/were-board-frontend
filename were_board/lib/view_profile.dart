import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewProfile extends StatefulWidget {
  final String email;

  ViewProfile({this.email});

  @override
  ViewProfileState createState() => ViewProfileState();
}

Future<User> fetchUser(String nameStr) async {
  final response =
      await http.get('https://were-board.herokuapp.com/email/' + nameStr);
  //print("response : " + response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return User.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<User> fetchUserbyId(String id) async {
  final response =
      await http.get('https://were-board.herokuapp.com/user/' + id);
  //print("response : " + response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return User.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class ViewProfileState extends State<ViewProfile> {
  Future<User> user;

  @override
  void initState() {
    super.initState();
    user = fetchUser(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    final String imgUrl =
        'http://alefbetnyc.com/wp-content/uploads/2016/07/default-avatar.png';
    final double _radius = 100;
    final double _height = 2;
    return new Stack(children: <Widget>[
      new Container(
        color: Colors.white,
      ),
      new Image.network(
        imgUrl,
        fit: BoxFit.fill,
      ),
      new Scaffold(
          resizeToAvoidBottomPadding: false,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            title: Text("View profile"),
            backgroundColor: Colors.redAccent,
            automaticallyImplyLeading: false,
          ),
          body: new Center(
              child: new Column(children: <Widget>[
            new SizedBox(
              height: _radius / 2,
            ),
            new CircleAvatar(
              radius: _radius,
              backgroundImage: NetworkImage(imgUrl),
            ),
            FutureBuilder<User>(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: _height,
                            fontSize: 50));
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }),
            new Divider(
              height: _height * 4,
              color: Colors.black,
            ),
            new SizedBox(height: _radius / 4),
            new Text(
              'Attended Events',
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
          ])))
    ]);
  }
}

class User {
  final int id;
  final String name;

  User({this.name, this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      id: json['id'] as int,
    );
  }
}
