import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_tabs.dart';
import 'register.dart';


const users = const {
  'aa@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

 BuildContext init;

class LoginScreen extends StatelessWidget {
  final String url = 'https://were-board.herokuapp.com/';
  Duration get loginTime => Duration(milliseconds: 2250);

    Future<String> _createUser(LoginData data) {
    return Future.delayed(loginTime).then((_) async {
      var checkExists = await http.get(url+'email/${data.name}');
      if(checkExists.body == "Some"){
        return 'Email already has an account associated to it!';
      }
      Navigator.push(init, MaterialPageRoute(builder: (context) => Register(email: data.name, password: data.password)));
      return null;
    });
  }
  
  Future<String> _authUser(LoginData data) {
    return Future.delayed(loginTime).then((_) async {
      var body = {'email': data.name, 'password': data.password};
      var bodyJSON = json.encode(body);
      var response = await http.post(url + 'login', 
      headers: {'Content-Type': 'application/json'},
      body: bodyJSON);
      if(response.statusCode == 200){
        Navigator.push(
                      init,
                      MaterialPageRoute(builder: (context) => HomePage()),
            );
      }else{
        return 'Email or password wrong!';
      }
      
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    init = context;
    return FlutterLogin(
        theme: LoginTheme(pageColorLight: Colors.blueGrey,
        pageColorDark: Colors.deepOrange),
        logo: "images/logo.png",
        onLogin: _authUser,
        onSignup: _createUser,
        onRecoverPassword: _recoverPassword,
        
      );
  }
}