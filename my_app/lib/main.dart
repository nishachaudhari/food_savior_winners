import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
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
        home: Wrapper(),
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Color(0xFF94AE3F),              // light forest green
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Color(0xFF94AE3F),              // light forest green
          ),
          textTheme: TextTheme(
            body1: TextStyle(color: Color(0xFF101321)),
          ),
          brightness: Brightness.dark,
          primaryColor: Color(0xFF94AE3F),         // light forest green
          backgroundColor: Color(0xFF243754),      // dark calm blue
          accentColor: Color(0xFFEBEBEB),    // very light grey white
          //canvasColor: Color(0xFF94AE3F),
          canvasColor: Color(0xFFEBEBEB),
          // Define the default font family.
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
