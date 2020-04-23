import 'package:flutter/material.dart';
import 'package:my_app/screens/account/accountForm.dart';
import 'package:my_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:my_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:my_app/screens/help/help.dart';
import 'dart:io';



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

    final helpButton = Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xFF048D79),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => help()));
            },
            child: Text("Help",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                //style: style.copyWith(
                   // color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          )
        );

    final picsPastOrders =
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
                      if (snapshot.data.documents[index]['eater']== user.uid && snapshot.data.documents[index]['order']== "picked up")
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

    final pendingApproval =
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
              if (snapshot.data.documents[index]['eater']== user.uid && snapshot.data.documents[index]['order']== "pending")
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


    final awaitingPickup =
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
              if (snapshot.data.documents[index]['eater']== user.uid && snapshot.data.documents[index]['order']== "claimed")
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
            backgroundColor: Color(0xFF048D79),
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
          SingleChildScrollView(
          child: StreamBuilder(
          stream: Firestore.instance.collection('users').document(user.uid).snapshots(),
          builder: (context, snapshot){
          if(!snapshot.hasData) return Text('loading data .... please wait');
          //String base64Image = base64Encode(File('my_app/screens/account/account.jpg').readAsBytesSync());
          //Uint8List bytes = base64Decode(base64Image);
          //if(snapshot.hasData) 
          Uint8List bytes = base64Decode(snapshot.data['photo']);
           final fname = snapshot.data['firstName'];
           final lname = snapshot.data['lastName'];
           final name = '$fname' + ' ' + '$lname' + '!';
          return Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
            children:<Widget>[
                Text("Welcome $name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.left),
                SizedBox(height:20),
                Image.memory(bytes, height: 150, width: 150),
                SizedBox(height:20),
                Text("Orders that are waiting for you to Pick Up: ", style: TextStyle(fontSize: 17.0)),
                awaitingPickup,
                SizedBox(height:20),
                Text("Your Orders Pending Approval: ", style: TextStyle(fontSize: 17.0)),
                pendingApproval,
                SizedBox(height: 20.0),
                Text("Past Orders: ", style: TextStyle(fontSize: 17.0)),
                picsPastOrders,
                helpButton
            ]
            )
          );
          }
          )
          )
        );
    }
}
