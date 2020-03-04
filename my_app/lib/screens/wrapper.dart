//this checks whether user is logged in and goes to the home screen 
//or if not logged in goes to login screen

import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/screens/bottombar.dart';
import 'package:provider/provider.dart';
import 'package:my_app/screens/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context){

    final user = Provider.of<User>(context); //accessing user data from provider everytime theres a new value
    
  

    if (user == null)
    {
      return Authenticate();
    }
    else{
      return bottombar();
    }
  

  }
}
