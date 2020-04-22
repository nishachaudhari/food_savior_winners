import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class trust extends StatefulWidget
{
  @override
  _trust createState() => _trust();
  }

class _trust extends State <trust>
{
    @override
  Widget build(BuildContext context) {

   

      return Scaffold(
       appBar: AppBar(
         centerTitle: false,
         title: Text("Trust and Safety"),
         backgroundColor: Color(0xFF048D79),
       ),

       body:
       SingleChildScrollView(
       child: Container(
         padding: EdgeInsets.all(15),
         child: Column (children: <Widget>[
            SizedBox (height: 20),
            Text("Community Standards:", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("INFO", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("No Weapons Policy:", style: TextStyle(fontSize: 25)),
            SizedBox (height: 20),
            Text("INFO", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("Zero Tolerance Policy:", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("INFO ", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("Anti Discrimination Policy:", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
         ]
       ),
       )
      )
      );
  }


}
