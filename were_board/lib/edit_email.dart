import 'package:flutter/material.dart';


class EditEmail extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Edit Email')),
      body: Center(
        child: Column
        (children: <Widget>[
          Container(
            width: 250.0,
            child: TextField(
            decoration: InputDecoration(
              labelText: "New Email",
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(25.0),
              ) ,
              hintText: 'Enter new email'
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