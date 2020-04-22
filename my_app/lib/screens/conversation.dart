import 'package:flutter/material.dart';
import 'package:my_app/screens/add/addForm.dart';
import 'package:my_app/screens/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:my_app/models/user.dart';
import 'package:my_app/screens/foodInfoEdit.dart';
import 'package:provider/provider.dart';
import 'package:my_app/screens/mapIcon.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_app/screens/foodInfo.dart';
import 'package:my_app/common/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/services/category_selector.dart';

class conversation extends StatefulWidget
{

  @override
  State <StatefulWidget> createState()
  {
    return _conversation();
  }
}

class _conversation extends State <conversation>
{
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

    return Scaffold(
      backgroundColor: accentColor,
      appBar: AppBar(
            centerTitle: false,
            title: Text("Conversations"),
            backgroundColor: accentColor,
            elevation: 0.0,
          ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: StreamBuilder(
                stream: Firestore.instance.collection('convo').snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData) return Text('loading data .... please wait');
                  int length;
                  if(snapshot.data.documents.length == null){
                    length = 0;
                  }else{
                    length = snapshot.data.documents.length;
                  }
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                      if (snapshot.data.documents[index]['clientID']== user.uid)
                        return Container(
                              margin: EdgeInsets.all(15.0),
                              height: 50,
                              child: FlatButton (
                                onPressed: (){
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => foodInfo2(index)),
                                  );
                                },
                                child:Text('TEST')
                              )
                        );
                        else return Container();
                      },
                    itemCount: snapshot.data.documents == null ? 0:length,
                  );
                }
              )
            )
          )
        ]
      )
    );


  }
}