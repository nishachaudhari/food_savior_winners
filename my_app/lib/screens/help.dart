import 'package:flutter/material.dart';
import 'package:my_app/screens/account/accountForm.dart';
import 'package:my_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:my_app/models/user.dart';
import 'package:provider/provider.dart';



class help extends StatefulWidget
{
  @override
  _help createState() => _help();
  }

class _help extends State<help>
{
  @override
  Widget build(BuildContext context) {

      return Scaffold(
       appBar: AppBar(
         centerTitle: false,
         title: Text("Help"),
         backgroundColor: Colors.green,
       ),

       body:
       Container(
            padding: EdgeInsets.all(15.0),
             child: Column (
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                Center(
                  child: Column(
                      children: <Widget>[
                      SizedBox(height: 20),
                      FlatButton(
                        child: Text("FAQs"),
                        onPressed: (){},
                      ),
                      FlatButton(
                        child: Text("contact"),
                        onPressed: (){}
                      )

                      ]
                 )
                )
               ]
             )
             )    
           );


  }





}