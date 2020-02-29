import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ApplyToEvent extends StatefulWidget {
  final String eventId;

  ApplyToEvent({this.eventId}); // Need a way to add event id to constructor from view events page (get the label element from the list?)
  @override
  ApplyToEventState createState() => ApplyToEventState();

}


Future<Event> fetchEvent(String eventId) async {
  final response =
  await http.get('https://were-board.herokuapp.com/event/' + eventId);
  //print("response : " + response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Event.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class ApplyToEventState extends State<ApplyToEvent> {
  Future<Event> event;

  @override
  void initState() {
    super.initState();
    event = fetchEvent(widget.eventId);
  }

  /* Need get event API to be implemented first*/
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
            title: Text("Apply to this event"),
            backgroundColor: Colors.lightBlueAccent,
            automaticallyImplyLeading: false,
          ),
          body: new Center(
              child: new Column(
                  children: <Widget>[
                    new SizedBox(height: _radius / 2,),
                    new CircleAvatar(radius: _radius, backgroundImage: NetworkImage(imgUrl),),
                    FutureBuilder<Event>(
                        future: event,
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

class Event {
  final String name;
  final String description;
  final String address;
  final String datetime;

  Event({this.name, this.description, this.address, this.datetime});
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'],
      description: json['description'],
      address: json['address'],
      datetime: json['datetime'],
    );
  }
}

