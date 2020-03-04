import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:were_board/login.dart';
import 'dart:convert';
import 'home_tabs.dart';

class EditName extends StatelessWidget {
  final String email;
  String url = 'https://were-board.herokuapp.com/user/profile/name/';
  final myController = TextEditingController();

  EditName({this.email});

  Future<void> upName(String arg) async {
    var body = {'name': arg};
    var jso = json.encode(body);
    http.Response response = await http.put(url + this.email,
        headers: {'Content-Type': 'application/json'}, body: jso);
    if (response.statusCode == 200) {
      Navigator.pushReplacement(init,
          MaterialPageRoute(builder: (context) => HomePage(email: this.email)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Name')),
      body: Center(
          child: Column(
        children: <Widget>[
          TextField(
            controller: myController,
            decoration: InputDecoration(
                labelText: "New name",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0)),
                hintText: "Enter new name"),
          ),
          FlatButton(
              onPressed: () {
                upName(myController.text);
              },
              child: Text("Save"))
        ],
      )),
    );
  }
}
