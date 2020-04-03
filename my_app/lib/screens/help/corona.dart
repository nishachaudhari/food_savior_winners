import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class corona extends StatefulWidget
{
  @override
  _corona createState() => _corona();
  }

class _corona extends State<corona>
{
    @override
  Widget build(BuildContext context) {

      return Scaffold(
       appBar: AppBar(
         centerTitle: false,
         title: Text("CoronaVirus (COVID-19) Response"),
         backgroundColor: Colors.green,
       ),

       body:
       Container(
         padding: EdgeInsets.all(15),
         child: Column (children: <Widget>[
            SizedBox (height: 20),
            Text("FoodSavior is comitted to the health and safety of our entire community. With the ongoing concern around coronavirus, we want to ...", style: TextStyle(fontSize: 25),)
         ]
       ),
       )
      );
  }


}