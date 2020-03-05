import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/services/auth.dart';
import 'package:my_app/services/database.dart';



class NewAccount extends StatefulWidget 
{
  final Function toggleView;
  NewAccount({ this.toggleView });
  
  @override
  _NewAccountState createState() => _NewAccountState();
  }

class _NewAccountState extends State<NewAccount>
{

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); //this will be able to track state of form (to make sure no blank items)

  //text field state

  String email = '';
  String password = '';
  String confirmPassword = '';
  String firstName = '';
  String lastName = '';
  String phone = '';
  String error = '';


  @override
  Widget build(BuildContext context) {

    

    final createButton = Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.green,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            child: Text("Create",
                textAlign: TextAlign.center,
                //style: style.copyWith(
                   // color: Colors.white, fontWeight: FontWeight.bold)),
          ),
            onPressed:()async{
              if(_formKey.currentState.validate()) { //validates form when create account pressed
                  dynamic result = await _auth.registerEmail(email, password);

                  if(result == null)
                  {
                    setState(()
                    {error = 'please supply valid email';}
                      );
                      
                   }
              }
            }
          )

        );

    final backButton = Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.green,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () => widget.toggleView(),
            child: Text("Return to Login",
                textAlign: TextAlign.center,
                //style: style.copyWith(
                   // color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          )
        );

    return Scaffold(
      body:Container(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Form(
            key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                      TextFormField(
                          validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                          onChanged: (val){
                            setState(()=>email = val);
                          },
                          decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Email Address",
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                          ) ,
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                          validator: (val) => val.isEmpty ? 'Enter a First Name' : null,
                          onChanged: (val){
                            setState(()=>firstName = val);
                          },
                          decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "First Name",
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                          ) ,
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                          validator: (val) => val.isEmpty ? 'Enter a Last Name' : null,
                          onChanged: (val){
                            setState(()=>lastName = val);
                          },
                          decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Last Name",
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                          ) ,
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                          validator: (val) => val.length<10 ? 'Enter a valid Phone Number' : null,
                          onChanged: (val){
                            setState(()=>phone = val);
                          },
                          decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Phone Number",
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                          ) ,
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                          validator: (val) => val.length<6 ? 'Enter a password 6+ characters long' : null,
                          onChanged: (val){
                            setState(()=>password = val);
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Password",
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                          ) ,
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                          validator: (val) => password!=val ? 'Your Passwords do not match' : null,
                          onChanged: (val){
                            setState(()=>confirmPassword = val);
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Confirm Password",
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                          ) ,
                        ),
                        SizedBox(height: 45.0),
                        createButton,
                        SizedBox(height: 20.0),
                        backButton,
                        SizedBox(height:12.0),
                        Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0)),
                        
            ],
          ),
        ),
      ),
    ),
    
    );
  }
}