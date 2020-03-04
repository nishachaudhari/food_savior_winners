import 'package:flutter/material.dart';
import 'package:my_app/services/auth.dart';
import 'package:my_app/screens/messages.dart';
import 'package:my_app/screens/add.dart';
import 'package:my_app/screens/account.dart';
import 'package:my_app/screens/home.dart';

class HomeScreen extends StatefulWidget
{
  @override
  State <StatefulWidget> createState()
  { 
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State <HomeScreen> 
{

  final AuthService _auth = AuthService();

  int _currentIndex = 0;

  final List<Widget> _children = [
    home(),
    messages(),
    account(),
    add(),

  ];


  @override
  Widget build(BuildContext context) {

    /*final logoutButton = Material(
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

    final label = Center(
        child: Padding (
          padding: const EdgeInsets.all(36.0),
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text('Home Screen', style: TextStyle(color:Colors.green, fontSize: 20, fontWeight: FontWeight.bold) ),
          SizedBox(height:15),
          logoutButton,
          ]
        ) 
       ),
      );
*/
    return Scaffold(
      body: _children[_currentIndex],
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
            icon: new Icon(Icons.person),
            title: new Text('Account'),
          ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.add),
           title: new Text('Add'),
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


