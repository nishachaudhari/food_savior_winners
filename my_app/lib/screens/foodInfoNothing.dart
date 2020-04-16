import 'package:flutter/material.dart';
import 'package:my_app/screens/messages.dart';
import 'package:my_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/models/user.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:my_app/screens/messages.dart';

class foodInfoNothing extends StatefulWidget
{
  final int index;
  const foodInfoNothing(this.index);

  @override
  State <StatefulWidget> createState()
  {
    return _foodInfoNothing();
  }
}

class _foodInfoNothing extends State <foodInfoNothing>
{


  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);


    return Scaffold(
       appBar: AppBar(
         centerTitle: false,
         title: Text(""),
         backgroundColor: Color(0xFF048D79),
       ),

       body:
       StreamBuilder(
         stream: Firestore.instance.collection('food').snapshots(),
         builder: (context, snapshot){
           if(!snapshot.hasData) return Text('loading data .... please wait');
           Uint8List bytes = base64Decode(snapshot.data.documents[widget.index]['photo']);
          int length = snapshot.data.documents.length;
          return Container(
            padding: EdgeInsets.all(15.0),
             child: Column (
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                Center(
                  child: Column(
                      children: <Widget>[
                    Image.memory(bytes,height: 200, width: 200),
                    SizedBox(height: 20),
                    Text(snapshot.data.documents[widget.index]['title'],style: TextStyle(color:Color(0xFF048D79), fontSize: 40)),
                    SizedBox(height: 30,),
                    Text (snapshot.data.documents[widget.index]['description'],style: TextStyle(color:Color(0xFF048D79), fontSize: 20)),
                    SizedBox(height: 30,),
                    Text ("Serving Size:", style: TextStyle(color: Color(0xFF048D79), fontSize:30)),
                    Text (snapshot.data.documents[widget.index]['amount'],style: TextStyle(color:Colors.black, fontSize: 20)),
                    SizedBox(height: 20,),
                    Text ("Date and Time:", style: TextStyle(color: Color(0xFF048D79), fontSize:30)),
                    Text (snapshot.data.documents[widget.index]['time'],style: TextStyle(color:Colors.black, fontSize: 20)),
                    Text (snapshot.data.documents[widget.index]['date'], style: TextStyle(color:Colors.black, fontSize: 20)),
                    SizedBox(height: 20,),
                    Text ("Location:", style: TextStyle(color: Color(0xFF048D79), fontSize:30)),
                    Text (snapshot.data.documents[widget.index]['location'],style: TextStyle(color:Colors.black, fontSize: 20)),
                    SizedBox(height: 20,),
                    Text ("Claimed by User:", style: TextStyle(color: Color(0xFF048D79), fontSize:30)),
                    SizedBox(height: 20,),  
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
