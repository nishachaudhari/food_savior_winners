import 'package:flutter/material.dart';
import 'package:my_app/services/auth.dart';
import 'package:my_app/screens/messages.dart';
import 'package:my_app/screens/add/add.dart';
import 'package:my_app/screens/account/account.dart';
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
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          //canvasColor: Color(0xFF048D79),     // green
          canvasColor: Theme.of(context).primaryColor,     // light green
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Colors.red,
          textTheme: Theme
            .of(context)
            .textTheme
            .copyWith(caption: new TextStyle(color: Colors.yellow))), // sets the inactive color of the `BottomNavigationBar`
          child: BottomNavigationBar(
            selectedItemColor: Color(0xFFEBEBEB),
            unselectedItemColor: Color(0xFF101321),
            showUnselectedLabels: true,

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
               title: new Text('Donate'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.person),
                title: new Text('Account'),
              ),
            ]
          ),
        ),
      );

  }
   void onTappedBar(int index)
  {
    setState((){_currentIndex = index;});
  }
}
