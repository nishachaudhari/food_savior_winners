import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:my_app/common/app_card.dart';
import 'package:my_app/common/app_card.dart';
import 'package:my_app/services/auth.dart';

class HomeScreen extends StatelessWidget 
{

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final logoutButton = Material(
          elevation: 0.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.green,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async{
              await _auth.signOut(); 
            },
            child: Text("Log Out"),
            //textAlign: TextAlign.center,
                //style: style.copyWith(
                   // color: Colors.white, fontWeight: FontWeight.bold)),
          )
        );


    return Scaffold(
      body: Center(
        child: Padding (
          padding: const EdgeInsets.all(36.0),
          child: 
          logoutButton,
        ) 
          ),
      );
  }
}


