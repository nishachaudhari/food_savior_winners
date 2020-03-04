import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class add extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    final label = Center(
      child: Padding (
          padding: const EdgeInsets.all(36.0),
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text('Add Food', style: TextStyle(color:Colors.green, fontSize: 20, fontWeight: FontWeight.bold) ),
          SizedBox(height:15),
         // logoutButton,
          ]
        ) 
       ),
    );

    return Scaffold(
      body:
      label
    );

  }
}