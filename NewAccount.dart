import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:my_app/common/app_card.dart';
import 'common/app_card.dart';
import 'login.dart';

class NewAccount extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppCard(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: "Email Address") ,
                        ),
                        TextFormField(
                        decoration: InputDecoration(labelText: "First Name") ,
                        ),
                        TextFormField(
                        decoration: InputDecoration(labelText: "Last Name") ,
                        ),
                        TextFormField(
                        decoration: InputDecoration(labelText: "Phone Number") ,
                        ),
                        TextFormField(
                        decoration: InputDecoration(labelText: "Password") ,
                        ),
                        TextFormField(
                        decoration: InputDecoration(labelText: "Confirm Password") ,
                        ),
                    ],
                  ),
                  ),
              ),
              AppCard( 
                child: Container(
                child: Column(
                children: <Widget> [
                  RaisedButton(
                  onPressed: (){
                     
                  },
                  child: Text('Submit'),
                  color: Colors.lightGreen[300],
                ),
                  RaisedButton(
                  onPressed: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                     );
                  },
                  child: Text('Back'),
                  color: Colors.lightGreen[300],
                ),
                ],
                ),
                ), 
                
              ),
            ],
          ),
      ),
    );
  }
}