import 'package:flutter/material.dart';
import 'package:my_app/screens/add/addForm.dart';





class add extends StatefulWidget 
{ 
  @override
  _addState createState() => _addState();
  }

class _addState extends State<add>
{


  @override
  Widget build(BuildContext context) {

    final addButton = Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.green,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            child: Text("Add Food",
                textAlign: TextAlign.center,
                //style: style.copyWith(
                   // color: Colors.white, fontWeight: FontWeight.bold)),
          ),
            onPressed:(){
            Navigator.push(context,MaterialPageRoute(builder: (context) => addForm()));
            }
          )

        );


    return Scaffold(
      body:Container(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 45.0),
              addButton,
              SizedBox(height: 20.0),
            ]
          )
        )
      )
    );
  }
}