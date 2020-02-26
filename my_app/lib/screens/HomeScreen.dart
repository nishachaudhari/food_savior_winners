import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:my_app/common/app_card.dart';
import 'package:my_app/common/app_card.dart';

class HomeScreen extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {

    final backButton = Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.green,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: (){
            Navigator.pop(context);
            },
            child: Text("Return to Login",
                textAlign: TextAlign.center,
                //style: style.copyWith(
                   // color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          )
        );


    return Scaffold(
      body: Center(
        child: Padding (
          padding: const EdgeInsets.all(36.0),
          child: 
          backButton,
        ) 
          ),
      );
  }
}


