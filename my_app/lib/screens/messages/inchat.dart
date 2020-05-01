import 'package:flutter/material.dart';
import 'package:my_app/models/chatmodel.dart';
import 'package:my_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:my_app/screens/foodInfoPages/foodInfoNothing.dart';

class inChat extends StatefulWidget
{
  final String convoID;
  final String receiverName;
  const inChat(this.convoID, this.receiverName);

  @override
  _inChat createState() => _inChat();
}


class _inChat extends State<inChat>
{
  @override
  Widget build(BuildContext context)
  {

    User user = Provider.of<User>(context);

    // List<UserData> senderInfo = [];

    // Future getSenderInfo(senderID)async{

    //   await Firestore.instance.collection('users').document(senderID).get().then((result){
    //             String name = result.data['firstName'];
    //             String photo = result.data['photo'];
    //             UserData data = UserData(firstName:name, photo:photo);

    //             setState(() {
    //             });
    //           }
    //     );
      
    //  };

    final messages = Container(
      height:500,
      width: 400,
      child: StreamBuilder(
        stream: Firestore.instance.collection('convo').document(widget.convoID).collection('Messages').orderBy('time').snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData) return Text('loading data .... please wait');
          int length = snapshot.data.documents.length;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {

              String senderID = snapshot.data.documents[index]['sender'];
              String name;
              //getSenderInfo(senderID);
              if(senderID != user.uid) name = widget.receiverName;
              else name = "Me";
              String message = snapshot.data.documents[index]['text'];
              //String avatarUrl = senderInfo[1];
              Timestamp time = snapshot.data.documents[index]['time'];
              //Uint8List bytes = base64Decode(avatarUrl);
              return Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Container(
                    decoration: new BoxDecoration (
                    color: Theme.of(context).accentColor
                  ),
                  child: ListTile(
                    // leading: CircleAvatar(
                    //   radius: 24.0,
                    //   //backgroundImage: Image.memory(bytes).image,
                    // ),
                    title: Row(
                      children: <Widget>[
                        Text(
                          name,
                          style: TextStyle(color: Color(0xFF101321)),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Text(
                          time.toDate().toString(),
                          style: TextStyle(fontSize: 12.0, color: Color(0xFF101321)),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      message,
                      style: TextStyle(color: Color(0xFF101321)),
                    )
                  ),
                  )
                ],
              ),
              );
            },
          itemCount: snapshot.data.documents == null ? 0:length,
          );
        }
      )
    );



    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
            centerTitle: false,
            title: Text("Messages"),
            
              actions: <Widget>[
                ]
          ),
      body: 
        Container(
          child: Column (
            children:<Widget>[
              messages,
            Container(
              margin: EdgeInsets.all(15.0),
              height: 61,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35.0),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 5,
                              color: Colors.grey)
                        ],
                      ),
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.face), onPressed: () {}),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Type Something...",
                                  border: InputBorder.none),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.photo_camera),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.attach_file),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Colors.teal, shape: BoxShape.circle),
                    child: InkWell(
                      child: Icon(
                        Icons.keyboard_voice,
                        color: Colors.white,
                      ),
                      onLongPress: () {

                      },
                    ),
                  )
                ],
              ),
            )
            ]
      ),
        )
    );

  }
}
