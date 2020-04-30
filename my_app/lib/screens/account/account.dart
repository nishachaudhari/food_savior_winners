import 'package:flutter/material.dart';
import 'package:my_app/screens/account/accountForm.dart';
import 'package:my_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:my_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:my_app/screens/help/help.dart';
import 'package:my_app/screens/foodInfoPages/foodInfoNothing.dart';



class account extends StatefulWidget
{
  @override
  _accountState createState() => _accountState();
  }

class _accountState extends State<account>
{
  final AuthService _auth = AuthService();



  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    final helpButton = Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Theme.of(context).primaryColor,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => help()));
            },
            child: Text("Help",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF101321)),
                //style: style.copyWith(
                   // color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          )
        );

    final picsPastOrders =
            Container(
              height:200,
              width: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                color: Theme.of(context).accentColor,
              ),
             child: StreamBuilder(
                stream: Firestore.instance.collection('food').snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData) return Text('loading data .... please wait');
                  int length = snapshot.data.documents.length;

                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                      Uint8List bytes = base64Decode(snapshot.data.documents[index]['photo']);
                      if (snapshot.data.documents[index]['eater']== user.uid && snapshot.data.documents[index]['order']== "picked up")
                        return Container(
                              margin: EdgeInsets.all(15.0),
                              height: 50,
                              child: FlatButton (
                                onPressed: (){
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => foodInfoNothing(index)),
                                  );
                                },
                                child: Image.memory(bytes, height: 200, width: 200),
                              ),
                        );
                      else
                        return Container();
                      },
                    itemCount: snapshot.data.documents == null ? 0:length,
                  );
                }
              )
            );

    final pendingApproval =
    Container(
      height:200,
      width: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
        color: Theme.of(context).accentColor,
      ),
      child: StreamBuilder(
        stream: Firestore.instance.collection('food').snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData) return Text('loading data .... please wait');
          int length = snapshot.data.documents.length;

          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
              Uint8List bytes = base64Decode(snapshot.data.documents[index]['photo']);
              if (snapshot.data.documents[index]['eater']== user.uid && snapshot.data.documents[index]['order']== "pending")
                return Container(
                      margin: EdgeInsets.all(15.0),
                      height: 50,
                      child: FlatButton (
                                onPressed: (){
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => foodInfoNothing(index)),
                                  );
                                },
                                child: Image.memory(bytes, height: 200, width: 200),
                              ),
                );
              else
                return Container();
              },
            itemCount: snapshot.data.documents == null ? 0:length,
          );
        }
      )
    );


    final awaitingPickup =
    Container(
      height:200,
      width: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
        color: Theme.of(context).accentColor,
      ),
      child: StreamBuilder(
        stream: Firestore.instance.collection('food').snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData) return Text('loading data .... please wait');
          int length = snapshot.data.documents.length;

          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
              Uint8List bytes = base64Decode(snapshot.data.documents[index]['photo']);
              if (snapshot.data.documents[index]['eater']== user.uid && snapshot.data.documents[index]['order']== "claimed")
                return Container(
                      margin: EdgeInsets.all(15.0),
                      height: 50,
                      child: FlatButton (
                                onPressed: (){
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => foodInfoNothing(index)),
                                  );
                                },
                                child: Image.memory(bytes, height: 200, width: 200),
                              )
                );
              else
                return Container();
              },
            itemCount: snapshot.data.documents == null ? 0:length,
          );
        }
      )
    );

        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text("My Food Savior"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => accountForm()));
                  }),
                FlatButton(onPressed: ()async {await _auth.signOut();},child: Text("Log Out", style: TextStyle(color: Color(0xFF101321), fontSize: 20.0)))
              ]
          ),

          body: Container(
            color: Theme.of(context).backgroundColor,      // dark calm blue
            child: SingleChildScrollView(
              child: StreamBuilder(
                stream: Firestore.instance.collection('users').document(user.uid).snapshots(),
                builder: (context, snapshot){
                if(!snapshot.hasData) return Text('loading data .... please wait');
                //String base64Image = base64Encode(File('my_app/screens/account/account.jpg').readAsBytesSync());
                //Uint8List bytes = base64Decode(base64Image);
                //if(snapshot.hasData)
                Uint8List bytes = base64Decode(snapshot.data['photo']);
                final fname = snapshot.data['firstName'];
                final lname = snapshot.data['lastName'];
                final name = '$fname' + ' ' + '$lname' + '!';
                return Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children:<Widget>[
                      Card(
                        color: Theme.of(context).accentColor,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Welcome $name",
                            style: TextStyle(color: Color(0xFF101321), fontSize: 20.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height:20),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Theme.of(context).accentColor,
                        ),
                        child: Image.memory(bytes, height: 150, width: 150),
                      ),
                      SizedBox(height:20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                          color: Theme.of(context).accentColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Orders that are waiting for you to Pick Up: ",
                            style: TextStyle(color: Color(0xFF101321), fontSize: 17.0),
                          ),
                        ),
                      ),
                      Divider(
                        height: 0.0,
                        indent: 10.0,
                        endIndent: 10.0,
                        thickness: 2.0,
                        color: Theme.of(context).backgroundColor,
                      ),
                      awaitingPickup,
                      SizedBox(height:20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                          color: Theme.of(context).accentColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Your Orders Pending Approval: ",
                            style: TextStyle(color: Color(0xFF101321), fontSize: 17.0),
                          ),
                        ),
                      ),
                      Divider(
                        height: 0.0,
                        indent: 10.0,
                        endIndent: 10.0,
                        thickness: 2.0,
                        color: Theme.of(context).backgroundColor,
                      ),
                      pendingApproval,
                      SizedBox(height: 20.0),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                          color: Theme.of(context).accentColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Past Orders: ",
                            style: TextStyle(color: Color(0xFF101321), fontSize: 17.0),
                          ),
                        ),
                      ),
                      Divider(
                        height: 0.0,
                        indent: 10.0,
                        endIndent: 10.0,
                        thickness: 2.0,
                        color: Theme.of(context).backgroundColor,
                      ),
                      picsPastOrders,
                      SizedBox(height: 20.0),
                      helpButton
                    ]
                  )
                );
              }
            )
          ),
          ),
        );
    }
}
