import 'package:flutter/material.dart';
import 'package:my_app/screens/account/accountForm.dart';
import 'package:my_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:my_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:my_app/services/database.dart';




class account extends StatefulWidget 
{ 
  @override
  _accountState createState() => _accountState();
  }

class _accountState extends State<account>
{
  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    final pics =
            Container(
              height:200,
              width: 500,
          
             child: StreamBuilder(
                stream: Firestore.instance.collection('food').snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData) return Text('loading data .... please wait');
                  int length = snapshot.data.documents.length;

                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                      Uint8List bytes = base64Decode(snapshot.data.documents[index]['photo']);
                      if (snapshot.data.documents[index]['user']!= user.uid)
                        return Container(
                              margin: EdgeInsets.all(15.0),
                              height: 50,
                              child: Image.memory(bytes, height: 200, width: 200),  
                        );
                      else 
                        return Container();
                      },
                    itemCount: snapshot.data.documents == null ? 0:length,
                  );
                }  
              )
            );

        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text("My Food Savior"),
            backgroundColor: Colors.green,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: (){ 
                    Navigator.push(context,MaterialPageRoute(builder: (context) => accountForm()));
                  }),
                FlatButton(onPressed: ()async {await _auth.signOut();},child: Text("Log Out",style: TextStyle(color:Colors.white)))
              ]
          ),

          body: 
          Column(
            children:<Widget>[
                SizedBox(height:20),
                Container(
                  child: Text("Past Orders: ")
                  ),
                pics, 
            ]
          )
        );
    }
}   