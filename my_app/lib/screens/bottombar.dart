import 'package:flutter/material.dart';
import 'package:my_app/services/auth.dart';
import 'package:my_app/screens/messages.dart';
import 'package:my_app/screens/add.dart';
import 'package:my_app/screens/account.dart';
import 'package:my_app/screens/HomeScreen.dart';



class bottombar extends StatefulWidget
{
  @override
  State <StatefulWidget> createState()
  { 
    return _bottombarState();
  }
}

class _bottombarState extends State <bottombar> 
{

  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeScreen(),
    messages(),
    add(),
    account(),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: (
        _children[_currentIndex]
      ),
      //body: logoutButton,
      bottomNavigationBar: BottomNavigationBar(
        
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        
        onTap: onTappedBar,
        
        currentIndex: _currentIndex,

        items: [
          BottomNavigationBarItem(
            icon: new Icon (Icons.home),
            title: new Text('Home'),
            ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Messages'),
          ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.add),
           title: new Text('Add'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text('Account'),
          ),
        ]
      ),
      
      );
      
  }
   void onTappedBar(int index)
  {
    setState((){_currentIndex = index;});
  }
}


