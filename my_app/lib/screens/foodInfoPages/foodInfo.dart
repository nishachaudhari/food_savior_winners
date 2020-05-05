import 'package:flutter/material.dart';
import 'package:my_app/screens/messages/inchat.dart';
import 'package:my_app/screens/messages/messages.dart';
import 'package:my_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/models/user.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:intl/intl.dart';

class foodInfo extends StatefulWidget
{
  final int index;
  const foodInfo(this.index);

  @override
  State <StatefulWidget> createState()
  {
    return _foodInfo();
  }
}

class _foodInfo extends State <foodInfo>
{


  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
       appBar: AppBar(
         centerTitle: false,
         title: Text(""),
         backgroundColor: Color(0xFF94AE3F),
       ),

       body:
       StreamBuilder(
         stream: Firestore.instance.collection('food').snapshots(),
         builder: (context, snapshot){
           if(!snapshot.hasData) return Text('loading data .... please wait');
           Uint8List bytes = base64Decode(snapshot.data.documents[widget.index]['photo']);
           String docID;
           docID = snapshot.data.documents[widget.index].documentID;
           String foodOwner = snapshot.data.documents[widget.index]['user'];
           String foodTitle = snapshot.data.documents[widget.index]['title'];
          int length = snapshot.data.documents.length;
          return Container(
            padding: EdgeInsets.all(15.0),
             child: Column (
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                Center(
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 3,),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Theme.of(context).accentColor,
                          ),
                          child: Column(
                            children: <Widget>[
                              Text(
                                snapshot.data.documents[widget.index]['title'],
                                style: TextStyle(color: Color(0xFF101321), fontSize: 35),
                                textAlign: TextAlign.center,
                              ),
                              Divider(
                                height: 12.0,
                              ),
                              Divider(
                                height: 0.0,
                                indent: 8.0,
                                endIndent: 8.0,
                                thickness: 2.0,
                                color: Theme.of(context).backgroundColor,
                              ),
                              Divider(
                                height: 12.0,
                              ),
                              Text (
                                snapshot.data.documents[widget.index]['description'],
                                style: TextStyle(color: Color(0xFF101321), fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Theme.of(context).accentColor,
                          ),
                          child: Column(
                            children: <Widget>[
                              Image.memory(bytes,height: 200, width: 200),
                              SizedBox(height: 6,),
                              Text(
                                "Serving Size:  " + snapshot.data.documents[widget.index]['amount'],
                                style: TextStyle(color: Color(0xFF101321), fontSize:30),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Theme.of(context).accentColor,
                          ),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Date and Time:",
                                style: TextStyle(color: Color(0xFF101321), fontSize:30),
                                textAlign: TextAlign.center,
                              ),
                              Divider(
                                height: 6.0,
                              ),
                              Divider(
                                height: 0.0,
                                indent: 8.0,
                                endIndent: 8.0,
                                thickness: 2.0,
                                color: Theme.of(context).backgroundColor,
                              ),
                              Divider(
                                height: 6.0,
                              ),
                              Text(
                                snapshot.data.documents[widget.index]['time'],
                                style: TextStyle(color: Color(0xFF101321), fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                snapshot.data.documents[widget.index]['date'],
                                style: TextStyle(color: Color(0xFF101321), fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Theme.of(context).accentColor,
                          ),
                          child: Column(
                            children: <Widget>[
                              Text(
                                "Location:",
                                style: TextStyle(color: Color(0xFF101321), fontSize:30),
                                textAlign: TextAlign.center,
                              ),
                              Divider(
                                height: 6.0,
                              ),
                              Divider(
                                height: 0.0,
                                indent: 8.0,
                                endIndent: 8.0,
                                thickness: 2.0,
                                color: Theme.of(context).backgroundColor,
                              ),
                              Divider(
                                height: 6.0,
                              ),
                              Text(
                                snapshot.data.documents[widget.index]['location'],
                                style: TextStyle(color: Color(0xFF101321), fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Theme.of(context).primaryColor,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () async {
                              await DatabaseService(id:docID).editfoodStatus(
                                user.uid,
                                "pending"
                              );
                              String requestID = await DatabaseService().updaterequestData(foodOwner, user.uid, docID, "pending");
                              print(requestID);
                              String convoDocID = await DatabaseService().updateconvoData(foodOwner, user.uid, docID,requestID); //client then host, host is originally the current user who is requesting the food from the client who is the owner of the food. the user.uid is the person sending the first message
                              await DatabaseService().updateconvoMessageCollection(user.uid, "I would like to request your food item $foodTitle", Timestamp.fromDate(DateTime.now()), convoDocID);

                            //  String convoDocID2 = await DatabaseService().updateconvoData(user.uid, foodOwner);
                            //  await DatabaseService().updateconvoMessageCollection(user.uid, "I would like to request your food item $foodTitle", Timestamp.fromDate(DateTime.now()), convoDocID2);

                              Navigator.push(context,
                              MaterialPageRoute(builder: (context) => inChat(convoDocID,foodOwner)),
                              );



                            },
                            child: Text("Request Food!",
                                textAlign: TextAlign.center,
                                //style: style.copyWith(
                                  // color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                          )
                        )
                      ]
                 )
                )
               ]
               )

           );
          }
       )

    );
  }
}
