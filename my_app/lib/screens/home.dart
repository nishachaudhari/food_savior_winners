import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class home extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body:
      Text('Home Screen', style: TextStyle(color:Colors.green, fontSize: 20, fontWeight: FontWeight.bold) ),
    );

  }
}