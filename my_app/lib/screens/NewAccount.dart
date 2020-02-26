import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class NewAccount extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {

    final createButton = Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.green,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: (){},
            child: Text("Create",
                textAlign: TextAlign.center,
                //style: style.copyWith(
                   // color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          )
        );

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
      body:Container(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Email Address",
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                          ) ,
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "First Name",
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                          ) ,
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Last Name",
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                          ) ,
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Phone Number",
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                          ) ,
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Password",
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                          ) ,
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Confirm Password",
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                          ) ,
                        ),
                        SizedBox(height: 45.0),
                        createButton,
                        SizedBox(height: 20.0),
                        backButton,
            ],
          ),
      ),
    ),
    );
  }
}