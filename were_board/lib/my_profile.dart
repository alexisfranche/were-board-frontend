import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'edit_desc.dart';
import 'edit_name.dart';

class MyProfile extends StatefulWidget {
  final String email;

  MyProfile({this.email});

  @override
  MyProfileState createState() => MyProfileState(email: this.email);
}

Future<User> fetchUser(String emailStr) async {
  final response =
      await http.get('https://were-board.herokuapp.com/email/' + emailStr);
  //print("response : " + response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return User.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load profile');
  }
}

class MyProfileState extends State<MyProfile> {
  final String email;

  MyProfileState({this.email});

  Future<User> user;

  @override
  void initState() {
    super.initState();
    user = fetchUser(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    Color mySecondRed = const Color(0xFFC62828);
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
          appBar: AppBar(
            elevation: 0.0,
            title: Text("My Profile"),
            centerTitle: true,
            backgroundColor: mySecondRed,
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
                  } else if (snapshot.hasData &&
                      snapshot.data.description == null) {
                    return Text('Add description');
                  } else if (snapshot.hasData) {
                    return Text(snapshot.data.description,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            height: _height,
                            fontSize: 20));
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
              'Bio',
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),

            /* FutureBuilder<User>(
                    future: user,
                    builder: (context, snapshot) {
                      if (snapshot.data.description == null) {
                        return Text('Add description');
                      }
                      else if (snapshot.hasData){
                        return Text(snapshot.data.description, style: TextStyle(fontWeight: FontWeight.normal, height: _height, fontSize: 20));
                      }
                      else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    }), */

            new Row(children: <Widget>[
              Expanded(
                child: new RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditName(email: this.email)));
                  },
                  child: Text(
                    'Edit Name',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.teal,
                ),
              ),
              Expanded(
                child: new RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditDesc(email: this.email)));
                  },
                  child: Text(
                    'Edit Bio',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.teal,
                ),
              )
            ]),
          ])))
    ]);
  }
}

class User {
  final String name;
  final String description;
  final int id;

  User({this.id, this.name, this.description});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
