import 'package:flutter/material.dart';
import 'package:my_app/common/app_card.dart';
import 'common/app_card.dart';
import 'NewAccount.dart';
import 'HomeScreen.dart';

class LoginPage extends StatelessWidget 
{
const LoginPage({Key key}) : super(key: key);
  //Change in login.dart within lib
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
                ),
              AppCard(
                child: Container(
                child: Column(
                children: <Widget> [
                  RaisedButton(
                  onPressed: (){
                     Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewAccount()),
                     );
                  },
                  child: Text('Create New Account'),
                  color: Colors.lightGreen[300],
                ),
                  RaisedButton(
                  onPressed: (){
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                     );
                  },
                  child: Text('Login'),
                  color: Colors.lightGreen[300],
                ),
                ],
                ),
                ),
              ),
            ],
            ),)
    );
  }


}