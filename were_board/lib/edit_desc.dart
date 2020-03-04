import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:were_board/login.dart';
import 'dart:convert';
import 'home_tabs.dart';

class EditDesc extends StatelessWidget {
  final String email;
  String url = 'https://were-board.herokuapp.com/user/profile/desc/';
  final myController = TextEditingController();

  EditDesc({this.email});

  Future<void> upName(String arg) async {
    var body = {'description': arg};
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
      appBar: AppBar(title: Text('Edit Description')),
      body: Center(
          child: Column(
        children: <Widget>[
          TextField(
            controller: myController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                labelText: "New description",
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0)),
                hintText: "Enter new description"),
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
