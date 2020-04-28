import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/screens/messages/inchat.dart';
import 'package:provider/provider.dart';
import 'package:my_app/models/chatmodel.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

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

  void intoList(client){
    Firestore.instance.collection('users').getDocuments().then((querySnapshot){
      querySnapshot.documents.forEach((result)
        {   
            String _avatarUrl;
            if(result.data['photo'] != null) 
            _avatarUrl = result.data['photo'];
            String _name = result.data['firstName'];
            
            if(result.documentID == client)
              {
              ChatModel _data = ChatModel(avatarUrl: _avatarUrl, name: _name, datetime: "right now", message: "this message" );
              
              setState(() {
                    chatData.add(_data);
                });
              }   
         }
        );
      }
    );   
  }

  populate(){
    Firestore.instance.collection('convo').getDocuments().then((querySnapshot){
      querySnapshot.documents.forEach((result)
        {
          String client = result.data['clientID'];
          intoList(client); 
        }
        
      );
      }
    );
  }

  Widget build(BuildContext context)
  {
  User user = Provider.of<User>(context);

  

  return Scaffold(
    appBar: AppBar(
          centerTitle: false,
          title: Text("Messages"),
            actions: <Widget>[
              ]
        ),
      body: Container(
       color: Theme.of(context).backgroundColor,      // dark calm blue
        child: ListView.builder(
          itemCount: chatData.length,
          itemBuilder: (context, index) {
            ChatModel _model = chatData[index];
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
                        Navigator.push(context,MaterialPageRoute(builder: (context) => inChat()));
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
