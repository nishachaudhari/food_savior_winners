import 'package:my_app/screens/loginStuff/NewAccount.dart';
import 'package:my_app/screens/loginStuff/login.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showLogIn = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showLogIn = !showLogIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showLogIn) {
      return LoginPage(toggleView:  toggleView);
    } else {
      return NewAccount(toggleView:  toggleView);
    }
  }
}