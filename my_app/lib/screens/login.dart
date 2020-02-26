import 'package:flutter/material.dart';
import 'package:my_app/common/app_card.dart';
import 'package:my_app/screens/NewAccount.dart';
import 'package:my_app/screens/HomeScreen.dart';
import 'package:my_app/services/auth.dart';

class LoginPage extends StatefulWidget 
{
  @override
  _LoginPageState createState() => _LoginPageState();
  }

class _LoginPageState extends State<LoginPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); 

  //text field state

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {

    final logo = Text("FoodSavior", style: TextStyle(fontSize:32.0), textAlign: TextAlign.center,);

    final emailField = TextFormField(
      validator: (val) => val.isEmpty ? 'Enter an Email' : null,
      onChanged: (val){
          setState(()=>email = val);
      },
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
      validator: (val) => val.isEmpty ? 'Enter a password' : null,
      onChanged: (val){
        setState(()=>password = val);
      },
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
            onPressed: ()async{
                  if(_formKey.currentState.validate()) { //validates form when create account pressed
                  dynamic result = await _auth.signInEmail(email, password);
                  if(result == null)
                  {
                    setState(()=>error = 'could not sign in with those credentials');
                  }
                  
                  }
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
                child:Form(
                  key:_formKey,
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
                    SizedBox(height:12.0),
                        Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0)),
                  ],
                ),
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