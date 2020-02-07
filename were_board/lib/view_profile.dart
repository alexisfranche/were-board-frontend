import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ViewProfile extends StatefulWidget {
  @override
  ViewProfileState createState() => ViewProfileState();

}


Future<User> fetchUser(String userId) async {
  final response =
  await http.get('https://were-board.herokuapp.com/user/' + userId);
  print("respomse : " + response.body);
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
    user = fetchUser("6"); // This will be used when we connect the UI to the backend (6 is just a test ID)
  }

  @override
  Widget build(BuildContext context) {
    final String imgUrl = 'http://alefbetnyc.com/wp-content/uploads/2016/07/default-avatar.png';
    final double _radius = 100;
    final double _height = 2;
    return new Stack(children: <Widget>[
      new Container(color: Colors.white,),
      new Image.network(imgUrl, fit: BoxFit.fill,),
      new Scaffold(
        appBar: AppBar(
          title: Text("View profile"),
          backgroundColor: Colors.lightBlueAccent,
          automaticallyImplyLeading: false,
        ),
        body: new Center(
          child: new Column(
              children: <Widget>[
                new SizedBox(height: _radius / 2,),
                new CircleAvatar(radius: _radius, backgroundImage: NetworkImage(imgUrl),),
                FutureBuilder<User>(
                    future: user,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data.name, style: TextStyle(
                            fontWeight: FontWeight.bold, height: _height, fontSize: 50));
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    }),
                new Divider(height: _height * 4,color: Colors.black,),
                new SizedBox(height: _radius / 4),
                new Text('Attended Events', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),
              ]
          )
        )
      )

    ]);
  }
}

class User {
  final String name;
  User({this.name});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
    );
  }
}

