import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/screens/login.dart';
import 'package:my_app/screens/wrapper.dart';
import 'package:my_app/services/auth.dart';
import 'package:provider/provider.dart';

//import 'package:reusable_cards/pages/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(      
      value:AuthService().user,  //stream provider is listening to this stream so now anything inside wrapper
      child: MaterialApp(        // can access can now access user data provided by streamprovider
        home: Wrapper()
        ), 
    );
  }
}