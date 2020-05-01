import 'package:flutter/material.dart';
import 'package:my_app/screens/help/gettingStarted.dart';
import 'package:my_app/screens/help/guideFAQ.dart';
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
       ),

       body:
       Container(
            color: Theme.of(context).backgroundColor,      // dark calm blue
            padding: EdgeInsets.all(15.0),
             child: Column (
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                Center(
                  child: Column(
                      children: <Widget>[
                      SizedBox(height: 20),
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: (){
                          Navigator.push(
                            context,
                             MaterialPageRoute(builder: (context) => gettingStarted()));
                          },
                        child: Row (children: <Widget>[
                          Text("Getting Started with FoodSavior", style: (TextStyle(fontSize: 20))),
                          Icon(Icons.keyboard_arrow_right),
                          ],
                          )
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        Navigator.push(
                            context,
                             MaterialPageRoute(builder: (context) => guideFAQ()));
                      },
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
