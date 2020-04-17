import 'package:flutter/material.dart';
import 'package:my_app/screens/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/models/user.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:typed_data';



class messages extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {

    User user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
            centerTitle: false,
            title: Text("Messages"),
            backgroundColor: Color(0xFF048D79),
              actions: <Widget>[
                ]
          ),
      body: Container(
        
      ),
    );

  }
}
