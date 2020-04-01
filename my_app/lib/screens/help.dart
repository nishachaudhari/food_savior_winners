import 'package:flutter/material.dart';
//import 'package:url_launcher/url_launcher.dart';


class help extends StatefulWidget
{
  @override
  _help createState() => _help();
  }

class _help extends State<help>
{


  /*void sendEmail(String email) async {
    var url = 'sms:9542492027';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
*/
  @override
  Widget build(BuildContext context) {

      return Scaffold(
       appBar: AppBar(
         centerTitle: false,
         title: Text("Help"),
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
                      FlatButton(
                        child: Text("FAQs"),
                        onPressed: (){},
                      ),
                      FlatButton(
                        child: Text("Contact"),
                        onPressed: (){
                          //sendEmail('nxc439@miami.edu');
                        }
                      )

                      ]
                 )
                )
               ]
             )
             )    
           );


  }





}