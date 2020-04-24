import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class gettingStarted extends StatefulWidget
{
  @override
  _gettingStarted createState() => _gettingStarted();
  }

class _gettingStarted extends State<gettingStarted>
{
    @override
  Widget build(BuildContext context) {


      return Scaffold(
       appBar: AppBar(
         centerTitle: false,
         title: Text("Getting Started"),
       ),

       body:
       SingleChildScrollView(
       child: Container(
         color: Theme.of(context).backgroundColor,      // dark calm blue
         padding: EdgeInsets.all(15),
         child: Column (children: <Widget>[
            SizedBox (height: 20),
            Text("How to use FoodSavior:", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("To sign up for FoodSavior all you need is a working email. Simply download the app onto your Iphone or Android and tap Create New Account. Once you've opened the app, you can go to account by navigating along the bottom bar to the far right. Press the settings icon on the top to add a profile picture, your name, and phone number.", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("To Order Food:", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("The home screen shows you what food is available closest to you. Just tap an item to get started and hit request food. This will direct you to the messaging portion of the app. You can send the generic request to the food owner or personalize it. They can then accept or deny your request, and you may coordinate details with them personally. Your pending requests, accepted requests, and past orders will be under your account screen.", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("To Donate:", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("To Donate food navigate to the Donating section marked by a plus sign on the bottom barbar. Simply press Add Food, add the details of your food and wait for any requests. If you receive a request it will pop up in your messages portion of the app. Then you can view the users basic information and accept or deny their request. All your added food will be shown in the donate section of the app, including food that has already been claimed, and unclaimed food. From this section you can also edit any food details.", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
         ]
       ),
       )
      )
      );
  }


}
