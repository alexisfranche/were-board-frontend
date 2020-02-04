import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Register extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(title: Text("We're Board"),
                      leading: null,
                       automaticallyImplyLeading: false),
      body: FormBuilder(child: 
        Column(children: 
          <Widget>[
            FormBuilderTextField(
            attribute: "name",
            decoration: InputDecoration(labelText: "Name"),
            validators: [
              FormBuilderValidators.numeric(),
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
          ]
        )
      ),
    );
  }

}