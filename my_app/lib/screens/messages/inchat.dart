import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_app/services/database.dart';
import 'package:my_app/models/user.dart' as model;
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart';


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

    model.User user = Provider.of<model.User>(context);

    String _message = '';

    final myController = TextEditingController();

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
          child: StreamBuilder(
            stream: Firestore.instance.collection('convo').document(widget.convoID).snapshots(),
             builder: (context, snapshot){
              String client = snapshot.data['clientID'];
              String host = snapshot.data['hostID'];
              String requestID = snapshot.data['requestID'];
              String foodID = snapshot.data['foodID'];
              var request = Firestore.instance.collection('request').document(requestID).get();
              request.then((result){
                String status = result.data['status'];
              });
          return Column (
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
                          Expanded(
                            child: TextFormField(
                              controller: myController,
                              style: TextStyle(color: Colors.black),
                              // onChanged: (val){
                              //   setState(()=>_message = val);
                              // },
                              decoration: InputDecoration(
                                  hintText: "Type Something...",
                                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                  hintStyle: TextStyle(color: Colors.black),
                                  border: InputBorder.none),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send),
                            color: Colors.grey,
                            onPressed: () async {
                              await DatabaseService().updateconvoMessageCollection(user.uid, myController.text, Timestamp.fromDate(DateTime.now()), widget.convoID);
                            },
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
            if(user.uid == client) 
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Theme.of(context).primaryColor,
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: ()async{
                  await DatabaseService(id:foodID).editfoodStatus(
                    user.uid,
                    "claimed"
                  );
                  await DatabaseService(id:requestID).updaterequestStatus("accepted");
                },
                child: Text("Accept",
                    textAlign: TextAlign.center,
                    //style: style.copyWith(
                      // color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              )
            ),
            if(user.uid != client) Text("Order Status:", style: TextStyle(color: Colors.white, fontSize: 20),),
            SizedBox(height: 20,),
            if(user.uid ==  client ) 
            Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Theme.of(context).primaryColor,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  
                    onPressed: ()async{
                    await DatabaseService(id:foodID).editfoodStatus(
                      "none",
                      "none"
                    );
                    await DatabaseService(id:requestID).updaterequestStatus("declined");
                    },
                  child: Text("Decline",
                      textAlign: TextAlign.center,
                      //style: style.copyWith(
                        // color: Colors.white, fontWeight: FontWeight.bold)),
                  ), 
                  
                )
              ),
              if(user.uid != client) Text('status', style: TextStyle(color: Colors.white, fontSize: 20),),
            ]
            );
          }
        )
        )
    );

  }
}
