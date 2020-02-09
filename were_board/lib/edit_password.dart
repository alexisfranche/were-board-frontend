import 'package:flutter/material.dart';


class EditPassword extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Edit Password')),
      body: Center(
        child: Column
        (children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
            decoration: InputDecoration(
              labelText: "New Password",
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ) ,
              hintText: 'Enter new password'
          ),
          ),
            ),
          
            RaisedButton(
              onPressed: null,//modify to have rest call
              child: Text('Save'),
              color: Colors.blue,
            )
        ],
        )
        
      ),
    );
  }
}