import 'package:flutter/material.dart';
import 'package:my_app/services/auth.dart';
import 'package:my_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:my_app/models/user.dart';

class account extends StatefulWidget
{
  @override
  State <StatefulWidget> createState()
  { 
    return _account();
  }
}

class _account extends State <account> 
{

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); //this will be able to track state of form (to make sure no blank items)

  //text field state
  
  String _currentFirstName = '';
  String _currentLastName = '';
  String _currentPhone = '';
  String error = '';

  @override
  Widget build(BuildContext context)
  {
       User user = Provider.of<User>(context);

    final logoutButton = Material(
         elevation: 0.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.green,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async{
              await _auth.signOut(); 
            },
            child: Text("Log Out"),
            //textAlign: TextAlign.center,
                //style: style.copyWith(
                   // color: Colors.white, fontWeight: FontWeight.bold)),
          )
        );


      return StreamBuilder<UserData>(
          stream: DatabaseService(uid:user.uid).userData,
          builder:(context,snapshot){
          if (snapshot.hasData){
            UserData userData = snapshot.data;
          return Container (
          child: Form(
            key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                        TextFormField(
                          validator: (val) => val.isEmpty ? 'Enter a First Name' : null,
                          onChanged: (val){
                            setState(()=>_currentFirstName= val);
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
                            setState(()=>_currentLastName = val);
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
                            setState(()=>_currentPhone = val);
                          },
                          decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Phone Number",
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: BorderSide(color: Colors.green))
                          ) ,
                        ),
                        SizedBox(height: 45.0),
                        Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.green,
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              child: Text("Update Information",
                                  textAlign: TextAlign.center,
                                  //style: style.copyWith(
                                    // color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                              onPressed:()async{
                                if (_formKey.currentState.validate())
                                {
                                  await DatabaseService(uid:user.uid).updateUserData(
                                    _currentFirstName ?? snapshot.data.firstName, 
                                    _currentLastName ?? snapshot.data.lastName, 
                                    _currentPhone ?? snapshot.data.phone);   
                                }
                              }
                            )

                        ),
                        SizedBox(height: 45.0),
                        logoutButton,
                        SizedBox(height: 20.0),
                        Text(error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0)),
                        
            ],
          ),
        ),
          ),
      );
          }
          else {
            print('no changes made');
          }
          }
      );
   // ),
    //);

  }
}
