import 'package:flutter/material.dart';
import 'package:my_app/screens/help/accountHelp.dart';
import 'package:my_app/screens/help/corona.dart';
import 'package:my_app/screens/help/guide.dart';
import 'package:my_app/screens/help/orders.dart';
import 'package:my_app/screens/help/trust.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_app/screens/help/corona.dart';


class help extends StatefulWidget
{
  @override
  _help createState() => _help();
  }

class _help extends State<help>
{


  void sendText(String text) async {
    var url = 'sms:$text';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void sendEmail(String email) async {
    var url = 'mailto:$email';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {

      return Scaffold(
       appBar: AppBar(
         centerTitle: false,
         title: Text("Help"),
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
                      Text("Popular Answers", style: (TextStyle (fontSize: 20, color: Colors.white)),),
                      Container(
                        height:1.0,
                        width:400.0,
                        color:Colors.white,),
                      SizedBox(height: 20),
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: (){
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => corona()));
                        },
                        child: Row (children: <Widget>[
                          Text("CoronaVirus (COVID-19) Response", style: (TextStyle(fontSize: 20, color: Colors.white))),
                          Icon(Icons.keyboard_arrow_right),
                          ],
                          )
                      ),
                      SizedBox(height: 20),
                      Text("Browse Help Topics", style: (TextStyle (fontSize: 20, color: Colors.white)),),
                      Container(
                        height:1.0,
                        width:400.0,
                        color:Colors.white,),
                      SizedBox(height: 20),
                      RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => guide()));

                      },
                      child: Row (children: <Widget>[
                        Text("Guide to FoodSavior", style: (TextStyle(fontSize: 20))),
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
                                  MaterialPageRoute(builder: (context) => accountHelp()));
                      },
                      child: Row (children: <Widget>[
                        Text("Account", style: (TextStyle(fontSize: 20, color: Colors.white))),
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
                                  MaterialPageRoute(builder: (context) => orderHelp()));
                      },
                      child: Row (children: <Widget>[
                        Text("Orders", style: (TextStyle(fontSize: 20, color: Colors.white))),
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
                                  MaterialPageRoute(builder: (context) => trust()));
                      },
                      child: Row (children: <Widget>[
                        Text("Trust and Safety", style: (TextStyle(fontSize: 20, color: Colors.white))),
                        Icon(Icons.keyboard_arrow_right),
                        ],
                        )
                      ),
                      SizedBox(height: 20),
                      Text("Contact us", style: (TextStyle (fontSize: 20, color: Colors.white)),),
                      Container(
                        height:1.0,
                        width:400.0,
                        color:Colors.white,),
                      SizedBox(height: 20),
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: (){sendText('9542492027');},
                        child: Row (children: <Widget>[
                          Icon(Icons.phone_iphone),
                          Text("SMS", style: (TextStyle(fontSize: 20, color: Colors.white))),
                          Icon(Icons.keyboard_arrow_right),
                          ],
                          )
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: (){sendEmail('nxc439@miami.edu');},
                        child: Row (children: <Widget>[
                          Icon(Icons.email),
                          Text("Email", style: (TextStyle(fontSize: 20, color: Colors.white))),
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
