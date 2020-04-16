import 'package:flutter/material.dart';
import 'package:my_app/screens/messages.dart';
import 'package:my_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/models/user.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:my_app/screens/messages.dart';
import 'package:my_app/screens/add/addEdit.dart';

class foodInfo2 extends StatefulWidget
{
  final int index;
  const foodInfo2(this.index);

  @override
  State <StatefulWidget> createState()
  {
    return _foodInfo2();
  }
}

class _foodInfo2 extends State <foodInfo2>
{



  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    void _showDialog(){
      showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text("Food Successfully Deleted!"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {Navigator.pop(context);}
              )
            ]
          );
        }
      );
    }



    return Scaffold(
       appBar: AppBar(
         centerTitle: false,
         title: Text(""),
         backgroundColor: Color(0xFF048D79),
       ),

       body:
       SingleChildScrollView(
       child: StreamBuilder(
         stream: Firestore.instance.collection('food').snapshots(),
         builder: (context, snapshot){
           if(!snapshot.hasData) return Text('loading data .... please wait');
           Uint8List bytes = base64Decode(snapshot.data.documents[widget.index]['photo']);
           String docID = snapshot.data.documents[widget.index].documentID;
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
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xFF048D79),
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) => addEdit(docID)));

                        },
                        child: Text("Edit Food",
                            textAlign: TextAlign.center,
                            //style: style.copyWith(
                              // color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      )
                    ),
                    SizedBox(height: 20),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xFF048D79),
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () {

                        Firestore.instance.collection('food').document(docID).delete();                            
                        Navigator.pop(context);
                        _showDialog();

                        },
                        child: Text("Delete Food",
                            textAlign: TextAlign.center,
                            //style: style.copyWith(
                              // color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      )
                    ),

                      ]
                 )
                )
               ]
               )

           );
          }
       )
       )
    );
  }
}
