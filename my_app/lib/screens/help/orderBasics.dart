import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class orderBasics extends StatefulWidget
{
  @override
  _orderBasics createState() => _orderBasics();
  }

class _orderBasics extends State <orderBasics>
{
    @override
  Widget build(BuildContext context) {

   

      return Scaffold(
       appBar: AppBar(
         centerTitle: false,
         title: Text("Order Basics"),
         backgroundColor: Color(0xFF048D79),
       ),

       body:
       SingleChildScrollView(
       child: Container(
         padding: EdgeInsets.all(15),
         child: Column (children: <Widget>[
            SizedBox (height: 20),
            Text("Order stuff:", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            
            SizedBox (height: 20),
            Text("INFO", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("INFO ", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("INFO", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
         ]
       ),
       )
      )
      );
  }


}
