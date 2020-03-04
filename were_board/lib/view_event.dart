import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'view_profile.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ViewEvent extends StatefulWidget {
  final int eventId;
  final int managerId;

  ViewEvent({this.eventId, this.managerId});

  @override
  ViewEventState createState() =>
      ViewEventState(eventId: this.eventId, managerId: this.managerId);
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
      id: json['id'] as int,
    );
  }
}

class ViewEventState extends State<ViewEvent> {
  final int eventId;
  final int managerId;
  Future<Event> event;
  Future<User> user;

  String retrievedUserId;
  String retrievedEventId;

  ViewEventState({this.eventId, this.managerId});

  @override
  void initState() {
    super.initState();
    event = fetchEvent(widget.eventId.toString());
    user = fetchUserbyId(widget.managerId.toString());
  }

  @override
  Widget build(BuildContext context) {
    Color mySecondRed = const Color(0xFFC62828);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text("View this event"),
        backgroundColor: mySecondRed,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: <Widget>[
          FutureBuilder(
              future: event,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  retrievedEventId = snapshot.data.id.toString();
                  return new Column(
                    children: <Widget>[
                      Text(snapshot.data.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              height: 3.0,
                              fontSize: 26)),
                      Divider(
                        height: 10.0,
                        color: Colors.black,
                      ),
                      Text(
                        snapshot.data.description,
                        textAlign: TextAlign.left,
                        style: TextStyle(height: 4.0, fontSize: 16),
                      ),
                      Text(
                        "Where:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 4.0,
                            fontSize: 16),
                      ),
                      Text(
                        snapshot.data.address,
                        textAlign: TextAlign.left,
                        style: TextStyle(height: 2.0, fontSize: 16),
                      ),
                      Text(
                        "When:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 4.0,
                            fontSize: 16),
                      ),
                      Text(
                        snapshot.data.datetime,
                        textAlign: TextAlign.left,
                        style: TextStyle(height: 2.0, fontSize: 16),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              }),
          FutureBuilder(
              future: user,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  retrievedUserId = snapshot.data.userId.toString();
                  return new Column(
                    children: <Widget>[
                      Text(
                        "Event organizer:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 4.0,
                            fontSize: 16),
                      ),
                      new InkWell(
                          child: Text(
                            snapshot.data.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(height: 2.0, fontSize: 16),
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewProfile(
                                      email: snapshot.data.email)))),
                      Divider(
                        height: 130.0,
                        color: Colors.black,
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              }),
          Container(
            child: (FlatButton(
              onPressed: () {
                joinEvent(retrievedUserId, retrievedEventId);
              },
              color: Colors.teal,
              textColor: Colors.white,
              disabledColor: Colors.red,
              disabledTextColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.redAccent,
              child: Text('Apply to this event!'),
            )),
          )
        ],
      ),
    );
  }
}

Future<User> getManagerName(Event event) async {
  Future<User> user = fetchUserbyId((event.managerId).toString());
  return user;
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

Future<void> joinEvent(String userId, String eventId) async {
  var body = {'event_id': eventId, 'user_id': userId};
  var jso = json.encode(body);
  http.Response response = await http.post(
      "https://were-board.herokuapp.com/join",
      headers: {'Content-Type': 'application/json'},
      body: jso);
  if (response.statusCode == 200) {
    print("success");
  }
}
