import 'package:flutter/material.dart';
import 'package:my_app/services/auth.dart';
import 'package:my_app/screens/messages.dart';
import 'package:my_app/screens/add.dart';
import 'package:my_app/screens/account.dart';
import 'package:my_app/screens/bottombar.dart';

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

    final label = Center(
        child: Padding (
          padding: const EdgeInsets.all(36.0),
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text('Home Screen', style: TextStyle(color:Colors.green, fontSize: 20, fontWeight: FontWeight.bold) ),
          SizedBox(height:15),
          logoutButton,
          ]
        ) 
       ),
      );

    return Scaffold(
      body: label,
    );
  }
}


