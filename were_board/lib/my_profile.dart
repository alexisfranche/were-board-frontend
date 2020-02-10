import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MyProfile extends StatefulWidget {
  @override
  MyProfileState createState() => MyProfileState();

}


Future<User> fetchUser(String userId) async {
  final response =
  await http.get('https://were-board.herokuapp.com/user/profile/' + userId);
  print("respomse : " + response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return User.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load profile');
  }
}

class MyProfileState extends State<MyProfile> {
  Future<User> user;

  @override
  void initState() {
    super.initState();
    user = fetchUser("20"); // This will be used when we connect the UI to the backend (6 is just a test ID)
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
          title: Text("My Profile"),
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
                new Text('Description', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 35, color: Colors.black),),
                
                FutureBuilder<User>(
                    future: user,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data.description, style: TextStyle(fontWeight: FontWeight.normal, height: _height, fontSize: 20));
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    }),
              ]
          )
        )
      )

    ]);
  }
}

class User {
  final String name;
  final String description;

  User({this.name, this.description});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      description: json['description'],
    );
  }
}

