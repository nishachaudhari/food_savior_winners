import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/screens/inchat.dart';
import 'package:provider/provider.dart';
import 'package:my_app/screens/chatmodel.dart';




class messages extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {

    User user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
            centerTitle: false,
            title: Text("Messages"),
            backgroundColor: Color(0xFF048D79),
              actions: <Widget>[
                ]
          ),
      body: Container(
        child: ListView.builder(
          itemCount: ChatModel.dummyData.length,
          itemBuilder: (context, index) {
            ChatModel _model = ChatModel.dummyData[index];
            return Column(
              children: <Widget>[
                Divider(
                  height: 12.0,
                ),
                ListTile(
                  leading: CircleAvatar(
                    radius: 24.0,
                    backgroundImage: NetworkImage(_model.avatarUrl),
                  ),
                  title: Row(
                    children: <Widget>[
                      Text(_model.name),
                      SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        _model.datetime,
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                  subtitle: Text(_model.message),
                  trailing: FlatButton.icon(
                    icon: Icon(Icons.arrow_forward_ios),
                    label: Text(" "),
                    //size: 14.0,
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => inChat()));
                    },
                  
                  ),
                ),
              ],
            );
          },
        ),
        
      ),
    );

  }
}
