import 'package:flutter/material.dart';
import 'package:my_app/common/app_card.dart';

class LoginPage extends StatelessWidget 
{
const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppCard(
                  child: Text("FoodSavior", style: TextStyle(fontSize:32.0), textAlign: TextAlign.center,),
                ),
              AppCard(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: "Email") ,
                        ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Password") ,
                        ),
                    ],
                    )
                ),
                )

            ],
            ),)
    );
  }


}