import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class orderHelp extends StatefulWidget
{
  @override
   _orderHelp createState() => _orderHelp();
  }

class  _orderHelp extends State <orderHelp>
{
    @override
  Widget build(BuildContext context) {

      return Scaffold(
       appBar: AppBar(
         centerTitle: false,
         title: Text("Orders"),
         backgroundColor: Color(0xFF048D79),
       ),

       body:
       Container(
            padding: EdgeInsets.all(15.0),
             child: Column (
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                Center(
                  child: Column(
                      children: <Widget>[
                      SizedBox(height: 20),
                      RaisedButton(
                        onPressed: (){
                        },
                        child: Row (children: <Widget>[
                          Text("Order Basics", style: (TextStyle(fontSize: 20))),
                          Icon(Icons.keyboard_arrow_right),
                          ],
                          )
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                      onPressed: (){},
                      child: Row (children: <Widget>[
                        Text("Order Issues", style: (TextStyle(fontSize: 20))),
                        Icon(Icons.keyboard_arrow_right),
                        ],
                        )
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        onPressed: (){
                        },
                        child: Row (children: <Widget>[
                          Text("Frequently Asked Questions", style: (TextStyle(fontSize: 20))),
                          Icon(Icons.keyboard_arrow_right),
                          ],
                          )
                      ),

                    ]
                 )
                )
               ]
             )
             )
           );
  }


}
