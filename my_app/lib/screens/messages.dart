import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class messages extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body:
      Text('Messages', style: TextStyle(color:Colors.green, fontSize: 20, fontWeight: FontWeight.bold) ),
    );

  }
}