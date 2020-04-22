import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class accountFAQ extends StatefulWidget
{
  @override
  _accountFAQ createState() => _accountFAQ();
  }

class _accountFAQ extends State<accountFAQ>
{
    @override
  Widget build(BuildContext context) {

      void _delete(){
      showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text("If you would like to delete your account, please contact us. Our information can be found under the help button on your account screen."),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {Navigator.pop(context);}
              )
            ]
          );
        }
      );
    }

    void _tips(){
      showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text("Food Savior currently doesn't support tips through the app. But you are welcome to tip in cash!"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {Navigator.pop(context);}
              )
            ]
          );
        }
      );
    }

    void _phone(){
      showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text("No. We require your email address and a verified mobile phone number to place an order on the FoodSavior app."),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {Navigator.pop(context);}
              )
            ]
          );
        }
      );
    }



      return Scaffold(
       appBar: AppBar(
         centerTitle: false,
         title: Text("Account FAQ"),
         backgroundColor: Color(0xFF048D79),
       ),

       body:
       SingleChildScrollView(
       child: Container(
         padding: EdgeInsets.all(15),
         child: Column (children: <Widget>[
            SizedBox (height: 20),
            RaisedButton(
              onPressed: (){
                 _delete();
                },
                child:Text("How do I delete my account?", style: (TextStyle(fontSize: 20))),
            ),
            SizedBox (height: 20),
            RaisedButton(
              onPressed: (){
                 _phone();
                },
                child:Text("I don't have a phone number can I still sign up?", style: (TextStyle(fontSize: 20))),
            ),
            SizedBox (height: 20),
            RaisedButton(
              onPressed: (){
                 _phone();
                },
                child:Text("I don't have an email address can I still sign up?", style: (TextStyle(fontSize: 20))),
            ),
            SizedBox (height: 20),
            SizedBox (height: 20),
            SizedBox (height: 20),
            SizedBox (height: 20),
         ]
       ),
       )
      )
      );
  }


}
