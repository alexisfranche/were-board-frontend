import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'package:were_board/home_tabs.dart';
import 'login.dart';
import 'dart:convert';

class Register extends StatelessWidget{
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final String url = 'https://were-board.herokuapp.com/';
  final String email;
  final String password;

  Register({this.email, this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(title: Text("We're Board"),
              centerTitle: true, 
              leading: GFButton(text: "Back",
              onPressed: (){
                          Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
              })
              ),
      body: FormBuilder(key: _fbKey,
        child: 
        Column(children: 
          <Widget>[
            FormBuilderTextField(
            attribute: "name",
            decoration: InputDecoration(labelText: "Name"),
            validators: [
              FormBuilderValidators.max(70),
            ],
          ),
          /*FormBuilderTextField(
            attribute: "age",
            decoration: InputDecoration(labelText: "Age"),
            validators: [
              FormBuilderValidators.numeric(),
              FormBuilderValidators.max(4),
            ],
          ),
          FormBuilderTextField(
            attribute: "Address",
            decoration: InputDecoration(labelText: "Address"),
            validators: [
              FormBuilderValidators.max(70),
            ],
          ),*/
          GFButton(text: "Create Account", 
          onPressed: () async {
            var body = {'name': _fbKey.currentState.fields['name'].currentState.value, 'email': this.email, 'password': this.password};
            var bodyJSON = json.encode(body);
            var response = await http.post(url+'user',
            headers: {'Content-Type': 'application/json'},
            body: bodyJSON);
            if(response.statusCode == 200){
              Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
            }
            return null;
            }),
          ]
        )
      ),
    );
  }

}