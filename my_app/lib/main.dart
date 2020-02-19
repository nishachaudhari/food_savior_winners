import 'package:flutter/material.dart';
import 'package:my_app/login.dart';
//import 'package:reusable_cards/pages/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp( home: LoginPage()  );
  }
}