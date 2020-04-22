import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class orderIssues extends StatefulWidget
{
  @override
  _orderIssues createState() => _orderIssues();
  }

class _orderIssues extends State<orderIssues>
{
    @override
  Widget build(BuildContext context) {

    _launchURL(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

      return Scaffold(
       appBar: AppBar(
         centerTitle: false,
         title: Text("Order Issues"),
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
