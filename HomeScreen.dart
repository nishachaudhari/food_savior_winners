import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:my_app/common/app_card.dart';
import 'common/app_card.dart';

class HomeScreen extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: (){
            Navigator.pop(context);
            },
            child: Text('Return to Login'),
            color: Colors.lightGreen[300],
          
          ),
      ),


    );
  }
}