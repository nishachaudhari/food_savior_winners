import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class guide extends StatefulWidget
{
  @override
  _guide createState() => _guide();
  }

class _guide extends State<guide>
{
    @override
  Widget build(BuildContext context) {

      return Scaffold(
       appBar: AppBar(
         centerTitle: false,
         title: Text("Guide to Food Savior"),
         backgroundColor: Colors.green,
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
                          Text("Getting Started with FoodSavior", style: (TextStyle(fontSize: 20))),
                          Icon(Icons.keyboard_arrow_right),
                          ],
                          )
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                      onPressed: (){},
                      child: Row (children: <Widget>[
                        Text("Frequently Asked Questions", style: (TextStyle(fontSize: 20))),
                        Icon(Icons.keyboard_arrow_right),
                        ],
                        )
                      ),
                      SizedBox(height: 20),
                      
                    ]
                 )
                )
               ]
             )
             )    
           );
  }
}