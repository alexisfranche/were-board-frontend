import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

void main() => runApp(MyApp());

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class MyApp extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
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
    return MaterialApp(
      color: Colors.blueGrey,
      title: "We're Board",
      home: FlutterLogin(
        theme: LoginTheme(pageColorLight: Colors.blueGrey,
        pageColorDark: Colors.deepOrange),
        logo: "images/logo.png",
        onLogin: _authUser,
        onSignup: _authUser,
        onRecoverPassword: _recoverPassword,
      )
    );
  }
}