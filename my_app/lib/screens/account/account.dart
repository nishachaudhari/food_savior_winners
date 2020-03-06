import 'package:flutter/material.dart';
import 'package:my_app/screens/account/accountForm.dart';
import 'package:my_app/services/auth.dart';




class account extends StatefulWidget 
{ 
  @override
  _accountState createState() => _accountState();
  }

class _accountState extends State<account>
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

    final updateButton = Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.green,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            child: Text("Update Account Information",
                textAlign: TextAlign.center,
                //style: style.copyWith(
                   // color: Colors.white, fontWeight: FontWeight.bold)),
          ),
            onPressed:(){
            Navigator.push(context,MaterialPageRoute(builder: (context) => accountForm()));
            }
          )

        );


    return Scaffold(
      body:Container(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 45.0),
              updateButton,
              SizedBox(height: 20.0),
              logoutButton,
            ]
          )
        )
      )
    );
  }
}