import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class corona extends StatefulWidget
{
  @override
  _corona createState() => _corona();
  }

class _corona extends State<corona>
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
         title: Text("CoronaVirus (COVID-19) Response"),
         backgroundColor: Color(0xFF048D79),
       ),

       body:
       SingleChildScrollView(
       child: Container(
         padding: EdgeInsets.all(15),
         child: Column (children: <Widget>[
            SizedBox (height: 20),
            Text("FoodSavior is comitted to the health and safety of our entire community. With the ongoing concern around coronavirus, we want to arm the entire FoodSavior Community with the proper resources to stay safe. In order to keep safe in these times we recommend:", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            GestureDetector
            (child:Text("Follow proven CDC guidelines and educate yourself.", style: TextStyle(decoration: TextDecoration.underline, fontSize: 25),),
            onTap: (){
              _launchURL('http://www.cdc.gov');
            },
            ),
            SizedBox (height: 20),
            Text("What is FoodSavior doing to keep me safe?", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("Health and Safety is paramount at FoodSavior. Our COVID-19 taskforce is closely monitoring the situation and looking into solutions to help our community. If we are notified that anyone using the platform- Customers or Donators- has tested positive for the virus, we will temporarily hold the account from using FoodSavior until an incubation period is complete. ", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("Meanwhile we suggest that donators and customers coordinate so as to not come into contact with each other. Perhaps set a specific time for pickup instead of a window so that the donator can leave the food outside for the customer to pick up. If you must come into contact with another person, we are requiring both parties to wear a mask and gloves. We encourage reporting any users who may not follow these guidelines. In addition, if you feel your food has been contaminated, dispose of it immediatelt and contact us.", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("Stay Safe!", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
         ]
       ),
       )
      )
      );
  }


}
