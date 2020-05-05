import 'package:flutter/material.dart';
import 'package:my_app/models/getLatest.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/screens/messages/inchat.dart';
import 'package:provider/provider.dart';
import 'package:my_app/models/chatmodel.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class messages extends StatefulWidget
{

  @override
  _messages createState() => _messages();
}


class _messages extends State <messages> {

 void initState(){
    super.initState();
    populate();
  }

  List<ChatModel> chatData = [];
  List<getLatest> latest = [];

  String formatDate(DateTime date){
        var formatter = new DateFormat('yyyy-MM-dd - kk:mm ');
        String formatted = formatter.format(date);
        return formatted;
  }

  void intoList(client, host, id)async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    String time = '';
    String text = '';
    var query = Firestore.instance.collection('convo').document(id).collection('Messages').orderBy('time', descending: true).limit(1).snapshots().first;
    query.then((result){
      DateTime dateTime = result.documents[0].data['time'].toDate();
      String time = formatDate(dateTime);
      text = result.documents[0].data['text'];
      getLatest _data = getLatest(time:time, message: text);
      setState(() {
        latest.add(_data);
        });
        Firestore.instance.collection('users').getDocuments().then((querySnapshot){
          querySnapshot.documents.forEach((result)
            {   
                String _avatarUrl;
                if(result.data['photo'] != null) 
                _avatarUrl = result.data['photo'];
                String _name = result.data['firstName'];
                if((result.documentID == client && uid==host) || result.documentID == host && uid == client)
                  {
                  ChatModel _data = ChatModel(avatarUrl: _avatarUrl, name: _name, datetime: time, message: text, id:id );
                  
                  setState(() {
                        chatData.add(_data);
                    });
                  }  
            });
          } 
        );// end of nested firestore query
      }
    ); //end of overarching firestore query 
  }

  populate(){
    Firestore.instance.collection('convo').getDocuments().then((querySnapshot){
      querySnapshot.documents.forEach((result)
        {
          String client = result.data['clientID'];
          String host = result.data['hostID'];
          String id = result.documentID;
          intoList(client, host, id); 
          //getTime(id);
        }
        
      );
      }
    );
    
  }


  Widget build(BuildContext context)
  {
  User user = Provider.of<User>(context);

  

  return Scaffold(
    backgroundColor: Theme.of(context).backgroundColor,
    appBar: AppBar(
          centerTitle: false,
          title: Text("Messages"),
            actions: <Widget>[
              ]
        ),
      body: Container(
        child: ListView.builder(
          itemCount: chatData.length,
          itemBuilder: (context, index) {
            ChatModel _model = chatData[index];
            String convoID = _model.id;
            String receiverName = _model.name;
            Uint8List bytes = base64Decode(_model.avatarUrl);
            return Container(
              color: Theme.of(context).accentColor,
              child: Column(
                children: <Widget>[
                  if (index != 0)
                    Divider(
                      height: 0.0,
                      indent: 10.0,
                      endIndent: 10.0,
                      thickness: 2.0,
                      color: Theme.of(context).backgroundColor,
                    ),
                  Divider(
                    height: 12.0,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 24.0,
                      backgroundImage: Image.memory(bytes).image,
                    ),
                    title: Row(
                      children: <Widget>[
                        Text(
                          _model.name,
                          style: TextStyle(color: Color(0xFF101321)),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Text(
                          _model.datetime,
                          style: TextStyle(fontSize: 12.0, color: Color(0xFF101321)),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      _model.message,
                      style: TextStyle(color: Color(0xFF101321)),
                    ),
                    trailing: FlatButton.icon(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF101321),
                      ),
                      label: Text(" "),
                      //size: 14.0,
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => inChat(convoID, receiverName, )));
                      },
                    ),
                  ),
                  Divider(
                    height: 12.0,
                  ),
                ],
              ),
            );
          },
        ),

      ),
    );

  }
}
