import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'home_tabs.dart';


const users = const {
  'aa@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
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
    return FlutterLogin(
        theme: LoginTheme(pageColorLight: Colors.blueGrey,
        pageColorDark: Colors.deepOrange),
        logo: "images/logo.png",
        onLogin: _authUser,
        onSignup: _authUser,
        onRecoverPassword: _recoverPassword,
        onSubmitAnimationCompleted: () {
          Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
  ); 
        },
      );
  }
}