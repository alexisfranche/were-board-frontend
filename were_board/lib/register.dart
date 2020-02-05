import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'login.dart';

class Register extends StatelessWidget{
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

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
          FormBuilderTextField(
            attribute: "age",
            decoration: InputDecoration(labelText: "Age"),
            validators: [
              FormBuilderValidators.numeric(),
              FormBuilderValidators.max(70),
            ],
          ),
          FormBuilderTextField(
            attribute: "Address",
            decoration: InputDecoration(labelText: "Address"),
            validators: [
              FormBuilderValidators.max(70),
            ],
          ),
          GFButton(text: "Create Account", 
          onPressed: () {
            
            }),
          ]
        )
      ),
    );
  }

}