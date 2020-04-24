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
import 'package:my_app/services/category_selector.dart';
import 'package:my_app/services/recent_chats.dart';
import 'package:my_app/models/message.dart';

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
  dynamic data;

  Future<dynamic> getUser(String userID) async {

    final DocumentReference document =   Firestore.instance.collection("convo").document(userID);

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
     setState(() {
       data = snapshot.data;
     });
    });
 }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    String hostName;

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
                      if (snapshot.data.documents[index]['clientID']== user.uid){
                        final Message chat = snapshot.data.documents[index]['message'];
                        // Stream<DocumentSnapshot> userSnap = Firestore.instance
                        //   .collection('users')
                        //   .document(snapshot.data.documents[index]['clientID'].toString())
                        //   .snapshots();
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
                                  child: Text('Test')
                                )
                              );
                      }
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