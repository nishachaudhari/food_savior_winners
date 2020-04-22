import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class orderFAQ extends StatefulWidget
{
  @override
  _orderFAQ createState() => _orderFAQ();
  }

class _orderFAQ extends State<orderFAQ>
{
    @override
  Widget build(BuildContext context) {

      void _cancel(){
      showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text("Yes! At any time, you may navigate to your account screen, current orders. Tap the food you want to cancel, and select cancel. This will also send a message to your FoodSavior"),
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
            title: new Text("Simply navigate to your messages. If you have requested someone's food, that means you have already sent them either a generic or customized message. You may continue talking to your Food Savior through this message chain."),
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

    void _pickUp(){
      showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text("If your order shows as picked up when you did not actually pick it up yet, please contact our customer support."),
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

    void _notThere(){
      showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text("Please contact our customer support if your Food Savior is not available with the food."),
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
         title: Text("Order FAQ"),
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
                 _cancel();
                },
                child:Text("Can I cancel my order?", style: (TextStyle(fontSize: 20))),
            ),
            SizedBox (height: 20),
            RaisedButton(
              onPressed: (){
                 _contact();
                },
                child:Text("How do I contact my FoodSavior?", style: (TextStyle(fontSize: 20))),
            ),
            SizedBox (height: 20),
            RaisedButton(
              onPressed: (){
                 _notThere();
                },
                child:Text("What if my Food Savior doesn't provide the food or is not there when I go to pick up my food??", style: (TextStyle(fontSize: 20))),
            ),
            SizedBox (height: 20),
             RaisedButton(
              onPressed: (){
                 _pickUp();
                },
                child:Text("What if my order says picked up but I didn't pick it up yet?", style: (TextStyle(fontSize: 20))),
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
