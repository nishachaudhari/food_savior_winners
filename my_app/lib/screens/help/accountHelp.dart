import 'package:flutter/material.dart';
import 'package:my_app/screens/help/accountFAQ.dart';
import 'package:my_app/screens/help/updateAccount.dart';
import 'package:url_launcher/url_launcher.dart';


class accountHelp extends StatefulWidget
{
  @override
   _accountHelp createState() => _accountHelp();
  }

class  _accountHelp extends State <accountHelp>
{
    @override
  Widget build(BuildContext context) {

      return Scaffold(
       appBar: AppBar(
         centerTitle: false,
         title: Text("Account"),
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
                        onPressed: (){
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => updateAccount()));

                        },
                        child: Row (children: <Widget>[
                          Text("Update Account", style: (TextStyle(fontSize: 20))),
                          Icon(Icons.keyboard_arrow_right),
                          ],
                          )
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => accountFAQ()));
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
