import 'package:flutter/material.dart';
import 'package:my_app/services/auth.dart';

class HomeScreen extends StatefulWidget
{
  @override
  State <StatefulWidget> createState()
  { 
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State <HomeScreen> 
{

  @override
  Widget build(BuildContext context) {

   
    final label = Center(
        child: Padding (
          padding: const EdgeInsets.all(36.0),
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text('Home Screen', style: TextStyle(color:Colors.green, fontSize: 20, fontWeight: FontWeight.bold) ),
          SizedBox(height:15),
         // logoutButton,
          ]
        ) 
       ),
      );

    return Scaffold(
      body: label,
    );
  }
}


