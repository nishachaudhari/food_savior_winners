import 'package:flutter/material.dart';
import 'package:my_app/screens/add/addForm.dart';
import 'package:my_app/screens/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:my_app/models/user.dart';
import 'package:my_app/screens/foodInfoEdit.dart';
import 'package:provider/provider.dart';




class add extends StatefulWidget
{
  @override
  _addState createState() => _addState();
  }

class _addState extends State<add>
{


  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    final addButton = Container (
        padding: EdgeInsets.all(36.0),
        child:Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xFF048D79),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            child: Text("Add Food",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                //style: style.copyWith(
                   // color: Colors.white, fontWeight: FontWeight.bold)),
          ),
            onPressed:(){
            Navigator.push(context,MaterialPageRoute(builder: (context) => addForm()));
            }
          )

        )
        )
        ;

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
                      if (snapshot.data.documents[index]['user']== user.uid)
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
                                child: Image.memory(bytes, height: 200, width: 200),
                              )
                        );
                        else return Container();
                      },
                    itemCount: snapshot.data.documents == null ? 0:length,
                  );
                }
              )
            );


    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
         title: Text("Donate"),
         backgroundColor: Color(0xFF048D79),
           actions: <Widget>[
             IconButton(
               icon: Icon(Icons.search),
               onPressed: (){
                 showSearch(context: context,delegate: Datasearch());
               })
           ],
       ),
      body:
      Column(
        children:<Widget>[
            SizedBox(height:20),
            Container(
              child: Text("Your Donated Food Items: ")
              ),
            pics,
            addButton,
        ]
      )
    );
  }
}
