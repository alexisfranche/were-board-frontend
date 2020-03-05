import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'package:were_board/home_tabs.dart';
import 'login.dart';
import 'dart:convert';

class CreateEvent extends StatelessWidget{
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final String url = 'https://were-board.herokuapp.com/';
  final int managerId;

  CreateEvent({this.managerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(title: Text("Create Event"),
              centerTitle: true, 
              leading: GFButton(text: "Back",
              onPressed: (){
                          Navigator.pop(context);
              })
              ),
      body: FormBuilder(key: _fbKey,
        child: 
        Column(children: 
          <Widget>[
            FormBuilderTextField(
            attribute: "name",
            decoration: InputDecoration(labelText: "Name Event"),
            validators: [
              FormBuilderValidators.max(70),
            ],
          ),
          FormBuilderTextField(
            attribute: "address",
            decoration: InputDecoration(labelText: "Address"),
            validators: [
              FormBuilderValidators.max(70),
            ],
          ),
          FormBuilderTextField(
            attribute: "game",
            decoration: InputDecoration(labelText: "Game"),
            validators: [
              FormBuilderValidators.max(70),
            ],
          ),
          FormBuilderTextField(
            attribute: "datetime",
            decoration: InputDecoration(labelText: "Date and time"),
            validators: [
              FormBuilderValidators.max(70),
            ],
          ),
          FormBuilderTextField(
            attribute: "description",
            decoration: InputDecoration(labelText: "description"),
            validators: [
              FormBuilderValidators.max(70),
            ],
          ),
         
          GFButton(text: "Create Event", 
          onPressed: () async {
            print("this buttttoooon");
            var body = {'name': _fbKey.currentState.fields['name'].currentState.value,
            'address': _fbKey.currentState.fields['address'].currentState.value,
            'game': _fbKey.currentState.fields['game'].currentState.value,
            'datetime': _fbKey.currentState.fields['datetime'].currentState.value,
            'description': _fbKey.currentState.fields['decription'].currentState.value,
            'status': "upcoming",
            'event_manager_id': this.managerId};
            var bodyJSON = json.encode(body);
            var response = await http.post(url+'event',
            headers: {'Content-Type': 'application/json'},
            body: bodyJSON);
            if(response.statusCode == 200){
              Navigator.pop(context);
            }
            return null;
            }),
          ]
        )
      ),
    );
  }

}