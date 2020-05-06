import 'package:flutter/material.dart';
import 'package:my_app/services/database.dart';
import 'package:my_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:my_app/screens/messages/messages.dart';


class inChat extends StatefulWidget
{
  final String convoID;
  final String receiverName;

  const inChat(this.convoID, this.receiverName);

  @override
  _inChat createState() => _inChat();
}


class _inChat extends State<inChat>
{
  @override
  Widget build(BuildContext context)
  {

    User user = Provider.of<User>(context);

    String _message = '';

    final myController = TextEditingController();

    void _showDialogAccept(){
      showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text("Congrats! You have accepted this request. Don't forget to press Picked Up when the exchange is done!"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {Navigator.pop(context);}
              )
            ]
          );
        }
      );
    }

    void _showDialogPickedUp(){
      showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text("Congrats! Your food has been picked up. Your conversation with the user has been deleted"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {Navigator.pop(context);}
              )
            ]
          );
        }
      );
    }

    void _showDialogDecline(){
      showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text("You have declined this request. The user will be appropriately notified, and this chat will be deleted."),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {Navigator.pop(context);}
              )
            ]
          );
        }
      );
    }


    String formatDate(DateTime date){
        var formatter = new DateFormat('yyyy-MM-dd - kk:mm ');
        String formatted = formatter.format(date);
        return formatted;
  }

    final messagesDisplay = Container(
      height:500,
      width: 400,
      child: StreamBuilder(
        stream: Firestore.instance.collection('convo').document(widget.convoID).collection('Messages').orderBy('time').snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData) return Text('loading data .... please wait');
          int length = snapshot.data.documents.length;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {

              String senderID = snapshot.data.documents[index]['sender'];
              String name;
              //getSenderInfo(senderID);
              if(senderID != user.uid) name = widget.receiverName;
              else name = "Me";
              String message = snapshot.data.documents[index]['text'];
              //String avatarUrl = senderInfo[1];
              DateTime dateTime = snapshot.data.documents[index]['time'].toDate();
              String time = formatDate(dateTime);
              //Uint8List bytes = base64Decode(avatarUrl);
              return Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Container(
                    decoration: new BoxDecoration (
                    color: Theme.of(context).accentColor
                  ),
                  child: ListTile(
                    // leading: CircleAvatar(
                    //   radius: 24.0,
                    //   //backgroundImage: Image.memory(bytes).image,
                    // ),
                    title: Row(
                      children: <Widget>[
                        Text(
                          name,
                          style: TextStyle(color: Color(0xFF101321)),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Text(
                          time,
                          style: TextStyle(fontSize: 12.0, color: Color(0xFF101321)),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      message,
                      style: TextStyle(color: Color(0xFF101321)),
                    )
                  ),
                  )
                ],
              ),
              );
            },
          itemCount: snapshot.data.documents == null ? 0:length,
          );
        }
      )
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
            centerTitle: false,
            title: Text("Messages"),
            
              actions: <Widget>[
                ]
          ),
      body: 
        Container(
          child: 
          StreamBuilder(
            stream: Firestore.instance.collection('convo').document(widget.convoID).snapshots(),
             builder: (context, snapshot){
              if(!snapshot.hasData) return Text('loading data .... please wait');
              String host = snapshot.data['hostID'];
              String client = snapshot.data['clientID'];
              String requestID = snapshot.data['requestID'];
              String foodID = snapshot.data['foodID'];
              print(requestID);
              return StreamBuilder(
                stream: Firestore.instance.collection('request').document(requestID).snapshots(),
                builder: (context, snap){
                String status = '';
                if(!snap.hasData) return Text('loading data .... please wait');
                status = snap.data['status'];
                return Column (
                  children:<Widget>[
                    messagesDisplay,
                  Container(
                    margin: EdgeInsets.all(15.0),
                    height: 61,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(35.0),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 3),
                                    blurRadius: 5,
                                    color: Colors.grey)
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: myController,
                                    style: TextStyle(color: Colors.black),
                                    // onChanged: (val){
                                    //   setState(()=>_message = val);
                                    // },
                                    decoration: InputDecoration(
                                        hintText: "Type Something...",
                                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                        hintStyle: TextStyle(color: Colors.black),
                                        border: InputBorder.none),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.send),
                                  color: Colors.grey,
                                  onPressed: () async {
                                    await DatabaseService().updateconvoMessageCollection(user.uid, myController.text, Timestamp.fromDate(DateTime.now()), widget.convoID);
                                  },
                                ),
                                
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                      ],
                    ),
                  ),
                  if(user.uid == client) 
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Theme.of(context).primaryColor,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: ()async{
                        await DatabaseService(id:foodID).editfoodStatus(
                          host,
                          "claimed"
                        );
                        await DatabaseService(id:requestID).updaterequestStatus("accepted");
                        _showDialogAccept();
                      },
                      child: Text("Accept",
                          textAlign: TextAlign.center,
                      ),
                    )
                  ),

                  if(user.uid != client) Text("Order Status:", style: TextStyle(color: Colors.white, fontSize: 20),),
                  
                  SizedBox(height: 20,),
                  
                  if(user.uid ==  client ) 
                  Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Theme.of(context).primaryColor,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: ()async{
                          await DatabaseService(id:foodID).editfoodStatus(
                            "none",
                            "none"
                          );
                          await DatabaseService(id:requestID).updaterequestStatus("declined");
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => messages()));
                          _showDialogDecline();
                          Firestore.instance.collection("convo").document(widget.convoID).delete();
                          },
                        child: Text("Decline",
                            textAlign: TextAlign.center,
                            //style: style.copyWith(
                              // color: Colors.white, fontWeight: FontWeight.bold)),
                        ), 
                        
                      )
                    ),

                    SizedBox (height: 20,),

                    if(user.uid != client) Text(status, style: TextStyle(color: Colors.white, fontSize: 20),),

                    if (user.uid == client && status == "accepted")
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Theme.of(context).primaryColor,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: ()async{
                          await DatabaseService(id:foodID).editfoodStatus(
                            host,
                            "picked up"
                          );
                          await DatabaseService(id:requestID).updaterequestStatus("picked up");
                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => messages()));
                          _showDialogPickedUp();
                          Firestore.instance.collection("convo").document(widget.convoID).delete();
                          },
                        child: Text("Picked Up",
                            textAlign: TextAlign.center,
                            //style: style.copyWith(
                              // color: Colors.white, fontWeight: FontWeight.bold)),
                        ), 
                        
                      )
                    ),

                  ]
                  );
                }
            );
          }
        )
        )
    );

  }
}
