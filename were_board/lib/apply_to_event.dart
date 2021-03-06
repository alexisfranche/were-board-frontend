import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ApplyToEvent extends StatefulWidget {
  final String eventId;

  ApplyToEvent(
      {this.eventId}); // Need a way to add event id to constructor from view events page (get the label element from the list?)
  @override
  ApplyToEventState createState() => ApplyToEventState();
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
    return new Container();
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
