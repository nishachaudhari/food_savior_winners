import 'package:flutter/material.dart';
import 'package:my_app/common/app_card.dart';
import 'package:my_app/screens/NewAccount.dart';
import 'package:my_app/screens/HomeScreen.dart';

class LoginPage extends StatelessWidget 
{
const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final logo = Text("FoodSavior", style: TextStyle(fontSize:32.0), textAlign: TextAlign.center,);

    final emailField = TextFormField(
      decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: "Email",
      enabledBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      focusedBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
        ),
      );
    
    final passwordField = TextFormField(
      obscureText: true,
      decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: "Password",
      enabledBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      focusedBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
        ),
      );

    final loginButton = Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.green,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: (){
                     Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                     );
                  },
            child: Text("Login",
                textAlign: TextAlign.center,
                //style: style.copyWith(
                   // color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          )
        );

    final createButton = Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.green,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: (){
                     Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewAccount()),
                     );
                  },
            child: Text("Create New Account",
                textAlign: TextAlign.center,
                //style: style.copyWith(
                    //color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        )
    );


    return Scaffold(
          body: Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 155.0,),
                    logo,
                    SizedBox(height: 45.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(height: 35.0,),
                    loginButton,
                    SizedBox(height: 25.0,),
                    createButton,
                    SizedBox (height: 15.0,)
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }

/*
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
                        decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Email",
                        border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
                        ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Password",
                        border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
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
            )
          ),
        )

            ],
            ),)
    );
  }


}
*/