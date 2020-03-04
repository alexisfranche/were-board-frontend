import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:were_board/view_event.dart';
import 'view_profile.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ViewAllEvents extends StatefulWidget {
  final String eventId;

  ViewAllEvents(
      {this.eventId}); // Need a way to add event id to constructor from view events page (get the label element from the list?)
  @override
  ViewAllEventsState createState() => ViewAllEventsState();
}

class Event {
  final String name;
  final String description;
  final String address;
  final String datetime;
  final int managerId;
  final int id;

  Event(
      {this.name,
      this.description,
      this.address,
      this.datetime,
      this.managerId,
      this.id});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        name: json['name'],
        description: json['description'],
        address: json['address'],
        datetime: json['datetime'],
        managerId: json['event_manager_id'] as int,
        id: json['id']);
  }
}

class ViewAllEventsState extends State<ViewAllEvents> {
  Future<List<Event>> events;
  Future<List<User>> users;

  @override
  void initState() {
    super.initState();
    events = fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    Color mySecondRed = const Color(0xFFC62828);
    double _height = 3.0;
    return new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text("Available events"),
          backgroundColor: mySecondRed,
          automaticallyImplyLeading: false,
        ),
        body: new FutureBuilder(
            future: events,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              List<Event> availableEvents = snapshot.data;
              User user;
              int index = 0;
              if (!snapshot.hasData) return CircularProgressIndicator();
              return new ListView.builder(
                scrollDirection: Axis.vertical,
                padding: new EdgeInsets.all(6.0),
                itemCount: availableEvents.length,
                itemBuilder: (BuildContext context, index) {
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
                                  fontSize: 20)),
/*                          if (user != null)
                            new Text('Event manager: ${user.name}',
                                style: TextStyle(height: _height)),*/
/*                          new Text('${availableEvents[index].description}',
                              style: TextStyle(height: 1)),*/
                          new Text('${availableEvents[index].address}',
                              style: TextStyle(height: _height)),
                          new Text('${availableEvents[index].datetime}',
                              style: TextStyle(height: _height)),

                          //new Text('${availableEvents[index].managerId}', style: TextStyle(height: _height)),

                          new FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewEvent(
                                          eventId: availableEvents[index].id,
                                          managerId: availableEvents[index]
                                              .managerId)));
                            },
                            // Simply call joinEvent for event 'availableEvents[index]'
                            color: Colors.teal,
                            textColor: Colors.white,
                            disabledColor: Colors.red,
                            disabledTextColor: Colors.white,
                            padding: EdgeInsets.all(8.0),
                            splashColor: Colors.redAccent,
                            child: Text('More info'),
                          )
                        ],
                      ));
                  index++;
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
