import 'package:flutter/material.dart';
import 'package:my_app/screens/add/addForm.dart';
import 'package:my_app/screens/homeScreen/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:my_app/models/user.dart';
import 'package:my_app/screens/foodInfoPages/foodInfoEdit.dart';
import 'package:my_app/screens/foodInfoPages/foodInfoNothing.dart';
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
          color: Color(0xFF101321),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            child: Text("Add Food",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF101321)),
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

    final picsPast =
            Container(
              height:200,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                color: Theme.of(context).accentColor,
              ),
             child: StreamBuilder(
                stream: Firestore.instance.collection('food').snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData) return Text('loading data .... please wait');
                  int length = snapshot.data.documents.length;

                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                      Uint8List bytes = base64Decode(snapshot.data.documents[index]['photo']);
                      if (snapshot.data.documents[index]['user']== user.uid && (snapshot.data.documents[index]['order'] == "picked up" || snapshot.data.documents[index]['order'] == "claimed" ))
                      {
                        return Container(
                              margin: EdgeInsets.all(15.0),
                              height: 50,
                              child: FlatButton (
                                onPressed: (){
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => foodInfoNothing(index)),
                                  );
                                },
                                child: Image.memory(bytes, height: 200, width: 200),
                              )
                        );
                      }
                        else return Container();
                      },
                    itemCount: snapshot.data.documents == null ? 0:length,
                  );
                }
              )
            );

    final picsCurrent =
            Container(
              height:200,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                color: Theme.of(context).accentColor,
              ),
             child: StreamBuilder(
                stream: Firestore.instance.collection('food').snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData) return Text('loading data .... please wait');
                  int length = snapshot.data.documents.length;

                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                      Uint8List bytes = base64Decode(snapshot.data.documents[index]['photo'] );
                      if (snapshot.data.documents[index]['user']== user.uid && snapshot.data.documents[index]['order'] == "none")
                      {
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
                      }
                        else return Container();
                      },
                    itemCount: snapshot.data.documents == null ? 0:length,
                  );
                }
              )
            );

    final picsPending =
            Container(
              height:200,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                color: Theme.of(context).accentColor,
              ),
             child: StreamBuilder(
                stream: Firestore.instance.collection('food').snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData) return Text('loading data .... please wait');
                  int length = snapshot.data.documents.length;
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                      Uint8List bytes = base64Decode(snapshot.data.documents[index]['photo']);
                      if (snapshot.data.documents[index]['user']== user.uid && snapshot.data.documents[index]['order'] == "pending")
                      {
                        return Container(
                              margin: EdgeInsets.all(15.0),
                              height: 50,
                              color: Theme.of(context).accentColor,
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
                      }
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
         title: Text("Donate", style: TextStyle(color: Color(0xFF101321), fontSize: 21.0)),
         backgroundColor: Color(0xFF94AE3F),
           actions: <Widget>[
             FlatButton.icon(
                label: Text("Add Food"),
                textColor: Color(0xFF101321),
                icon: Icon(
                  Icons.add,
                  color: Color(0xFF101321),
                ),
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => addForm()));
                },
              ),
             IconButton(
               icon: Icon(
                 Icons.search,
                 color: Color(0xFF101321),
               ),
               onPressed: (){
                 showSearch(context: context,delegate: Datasearch());
               }),

           ],
       ),
      body:
      Container(
        padding: EdgeInsets.all(15.0),
        color: Theme.of(context).backgroundColor,      // dark calm blue
        child: SingleChildScrollView(
          child: Column(
            children:<Widget>[
              SizedBox(height:20),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  color: Theme.of(context).accentColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Your Donated Items that have been Requested: ",
                    style: TextStyle(color: Color(0xFF101321), fontSize: 17.0),
                  ),
                ),
              ),
              Divider(
                height: 0.0,
                indent: 10.0,
                endIndent: 10.0,
                thickness: 2.0,
                color: Theme.of(context).backgroundColor,
              ),
              picsPending,
              SizedBox(height:20),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  color: Theme.of(context).accentColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Your Unclaimed Donated Food Items: ",
                    style: TextStyle(color: Color(0xFF101321), fontSize: 17.0),
                  ),
                ),
              ),
              Divider(
                height: 0.0,
                indent: 10.0,
                endIndent: 10.0,
                thickness: 2.0,
                color: Theme.of(context).backgroundColor,
              ),
              picsCurrent,
              SizedBox(height:20),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  color: Theme.of(context).accentColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Your Past Donated Food Items: ",
                    style: TextStyle(color: Color(0xFF101321), fontSize: 17.0),
                  ),
                ),
              ),
              Divider(
                height: 0.0,
                indent: 10.0,
                endIndent: 10.0,
                thickness: 2.0,
                color: Theme.of(context).backgroundColor,
              ),
              picsPast,
              // addButton,
            ]
          )
        )
      )
    );
  }
}
