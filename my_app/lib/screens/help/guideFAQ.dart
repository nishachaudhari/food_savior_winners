import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class guideFAQ extends StatefulWidget
{
  @override
  _guideFAQ createState() => _guideFAQ();
  }

class _guideFAQ extends State<guideFAQ>
{
    @override
  Widget build(BuildContext context) {

      void _cities(){
      showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text("Food Savior is currently available in all 50 states!"),
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

    void _contact(){
      showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text("If you navigate back to the main help screen and scroll down, there is an option to sms or email us!"),
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

    void _alcohol(){
      showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text("Yes! Feel free to donate alcohol. Our app will not show alcohol options to users under age 21. This is enforced when the user provides us with a govt ID right when creating an account."),
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
         title: Text("Guide to FoodSavior FAQ"),
       ),

       body:
       SingleChildScrollView(
       child: Container(
         color: Theme.of(context).backgroundColor,      // dark calm blue
         padding: EdgeInsets.all(15),
         child: Column (children: <Widget>[
            SizedBox (height: 20),
            RaisedButton(
              onPressed: (){
                 _cities();
                },
                child:Text("What cities is Food Savior available in?", style: (TextStyle(fontSize: 20))),
            ),
            SizedBox (height: 20),
            RaisedButton(
              onPressed: (){
                 _tips();
                },
                child:Text("How do I tip my FoodSavior?", style: (TextStyle(fontSize: 20))),
            ),
            SizedBox (height: 20),
            RaisedButton(
              onPressed: (){
                 _contact();
                },
                child:Text("How do I contact Customer Service?", style: (TextStyle(fontSize: 20))),
            ),
            SizedBox (height: 20),
             RaisedButton(
              onPressed: (){
                 _alcohol();
                },
                child:Text("Can I donate alcohol?", style: (TextStyle(fontSize: 20))),
            ),
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
