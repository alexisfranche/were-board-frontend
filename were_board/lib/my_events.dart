import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'view_profile.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Event.dart';

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

class MyEvents extends StatefulWidget {
  final String email;
  MyEvents({this.email});
  
  @override
  ViewMyEventsState createState() => ViewMyEventsState();
}

class ViewMyEventsState extends State<MyEvents> {
  Future<List<Event>> events;
  Future<List<User>> users;
  Future<User> user;

  @override
  void initState() {
    super.initState();
    events = fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    double _height = 3.0;
    return new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text("My Events"),
          backgroundColor: Colors.redAccent,
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){

          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
          ),
        body: new FutureBuilder(
            future: events,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              List<Event> availableEvents = snapshot.data;
              if (!snapshot.hasData) return CircularProgressIndicator();
              return new ListView.builder(
                scrollDirection: Axis.vertical,
                padding: new EdgeInsets.all(6.0),
                itemCount: availableEvents.length,
                itemBuilder: (BuildContext context, int index) {
                  user = fetchUserbyId(
                      (availableEvents[index].managerId).toString());
                  print("the user retrieved is" + user.toString());
                  return new Container(
                      margin: new EdgeInsets.only(bottom: 6.0),
                      padding: new EdgeInsets.all(6.0),
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          new Text('${availableEvents[index].name}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  height: _height,
                                  fontSize: 18)),
                          new Text('${availableEvents[index].description}',
                              style: TextStyle(height: _height)),
                          new Text('${availableEvents[index].address}',
                              style: TextStyle(height: _height)),
                          new Text('${availableEvents[index].datetime}',
                              style: TextStyle(height: _height)),
                          //new Text('${availableEvents[index].managerId}', style: TextStyle(height: _height)),

                          new FlatButton(
                            onPressed: () async {
                              int id = availableEvents[index].eventId;
                              final response = await http.delete('https://were-board.herokuapp.com/event/${id.toString()}');
                              setState(() {
                                events = fetchEvents();
                              });
                            },
                            // Simply call joinEvent for event 'availableEvents[index]'
                            color: Colors.redAccent,
                            textColor: Colors.white,
                            disabledColor: Colors.red,
                            disabledTextColor: Colors.white,
                            padding: EdgeInsets.all(8.0),
                            splashColor: Colors.redAccent,
                            child: Text('Cancel Event'),
                          )
                        ],
                      ));
                },
              );
            }));
  }
}

Future<List<Event>> fetchEvents() async {
  List<Event> events;
  final response = await http.get('https://were-board.herokuapp.com/event');
  if (response.statusCode == 200) {
    //print("response : " + response.body);
    // If the call to the server was successful, parse the JSONArray into a list.
    return events = (json.decode(response.body) as List)
        .map((i) => Event.fromJson(i))
        .toList();
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
