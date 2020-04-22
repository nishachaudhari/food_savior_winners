import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class updateAccount extends StatefulWidget
{
  @override
  _updateAccount createState() => _updateAccount();
  }

class _updateAccount extends State<updateAccount>
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
         title: Text("Update Account"),
         backgroundColor: Color(0xFF048D79),
       ),

       body:
       SingleChildScrollView(
       child: Container(
         padding: EdgeInsets.all(15),
         child: Column (children: <Widget>[
            SizedBox (height: 20),
            Text("Resetting your Password:", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("Sign out of your account. Then click Forgot Password. This will send a code to your phone which you input into the app. Now you will be prompted to enter your new password.", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("Updating your information:", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("Navigate to the account page using the bottombar. On the top right hand corner, select the gear icon. This will prompt you to enter in all your information, you can include your changes here.", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("Changing your email address:", style: TextStyle(fontSize: 25),),
            SizedBox (height: 20),
            Text("At this time FoodSavior does not allow you to change your email address. If you no longer have access to your previous email address, you will need to create a new FoodSavior account with the new address. ", style: TextStyle(fontSize: 30),),
         ]
       ),
       )
      )
      );
  }


}
