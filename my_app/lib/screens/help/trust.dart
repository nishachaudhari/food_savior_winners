import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class trust extends StatefulWidget
{
  @override
  _trust createState() => _trust();
  }

class _trust extends State <trust>
{
    @override
  Widget build(BuildContext context) {



      return Scaffold(
       appBar: AppBar(
         centerTitle: false,
         title: Text("Trust and Safety"),
       ),

       body:
       SingleChildScrollView(
       child: Container(
         color: Theme.of(context).backgroundColor,      // dark calm blue
         padding: EdgeInsets.all(15),
         child: Column (children: <Widget>[
            SizedBox (height: 20),
            Text("Community Standards:", style: TextStyle(fontSize: 25, color: Colors.white),),
            SizedBox (height: 20),
            Text("Safety: No one should feel unsafe using FoodSavior, and we will take immediate action to prevent and prohibit the following behavior: Harassment and causing harm to others. No one using FoodSavior should be subject to physical or sexual abuse, harassment, domestic violence, robbery, human trafficking, or other acts of violence. Unwanted contact. No one using FoodSavior should engage in unwanted contact with other members of the community during or after a delivery. Remember, FoodSavior provides a secure and anonymous method for Customers and FoodSavior to communicate through the FoodSavior app without exchanging personal numbers.", style: TextStyle(fontSize: 25,color: Colors.white ),),
            SizedBox (height: 20),
            Text("No Weapons Policy:", style: TextStyle(fontSize: 25, color: Colors.white)),
            SizedBox (height: 20),
            Text("Everyone should feel safe using FoodSavior. So while we know some of you might lawfully carry firearms, knives, or other similar items (we see you ninjas), FoodSavior maintains a strict “no weapons” policy for anyone using our app. Because it’s our policy, we reserve the right to decide what could be considered a “weapon.” That said, use common sense, and if you have any questions reach out to our Support Team.", style: TextStyle(fontSize: 25, color: Colors.white),),
            SizedBox (height: 20),
            Text("Zero Tolerance Policy:", style: TextStyle(fontSize: 25, color: Colors.white),),
            SizedBox (height: 20),
            Text("FoodSavior immediately denies access to anyone who abuses drugs or alcohol while performing services on the platform. If you ever feel unsafe dial 9-1-1 and notify law enforcement. After doing that, get in touch with us through the Help tab in the app.", style: TextStyle(fontSize: 25, color: Colors.white),),
            SizedBox (height: 20),
            Text("Anti Discrimination Policy:", style: TextStyle(fontSize: 25, color: Colors.white),),
            SizedBox (height: 20),
            Text("At FoodSavior we prohibit any and all discrimination based on race, ethnicity, national origin, religion, disability, sexual orientation, sex, marital status, gender, gender identity, age, or any other category protected under applicable law. Such discrimination may include, but is not limited to, refusing to provide or accept services based on these characteristics. Anyone who violates this policy by discriminating against members of the FoodSavior community may permanently lose access to the platform.", style: TextStyle(fontSize: 25, color: Colors.white),),
            SizedBox (height: 20),
         ]
       ),
       )
      )
      );
  }


}
