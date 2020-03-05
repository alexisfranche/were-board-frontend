import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Event.dart';

  Future<List<Event>> fetchEvents(String emailStr) async {
  List<Event> events;
  var user;
   final response1 =
      await http.get('https://were-board.herokuapp.com/email/' + emailStr);
  if (response1.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    user = User.fromJson(json.decode(response1.body)).userId;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load profile');
  }
  // int manager_id;
  // user.then((value) => manager_id = value.userId);
  final response2 = await http.get('https://were-board.herokuapp.com/event/manager/$user');
  if (response2.statusCode == 200) {
    //print("response : " + response.body);
    // If the call to the server was successful, parse the JSONArray into a list.
    events = (json.decode(response2.body) as List)
        .map((i) => Event.fromJson(i))
        .toList();

    return events;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class MyEvents extends StatefulWidget {
  final String email;
  

  MyEvents({this.email});
  
  @override
  ViewMyEventsState createState() => ViewMyEventsState(email: this.email);
}

class ViewMyEventsState extends State<MyEvents> {
  final String email;

  ViewMyEventsState({this.email});

  Future<List<Event>> events;
  Future<User> currentUser; 
  int manager_id;

  @override
  Future<void> initState(){
    super.initState();
    events = fetchEvents(widget.email);
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
                  //user = fetchUserbyId(
                  //    (availableEvents[index].managerId).toString());
                  //print("the user retrieved is" + user.toString());
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
                                events = fetchEvents(widget.email);
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

class User {
  final int userId;

  User({this.userId});

  factory User.fromJson(Map<String, dynamic> json) {
    var juserId = json['id'];

    if(juserId == null){
      juserId = -1;
    }

    return User(
        userId: juserId
    );
  }
}