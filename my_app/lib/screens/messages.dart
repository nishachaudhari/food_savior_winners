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
              actions: <Widget>[
                ]
          ),
      body: Container(
        color: Theme.of(context).backgroundColor,      // dark calm blue
        child: ListView.builder(
          itemCount: ChatModel.dummyData.length,
          itemBuilder: (context, index) {
            ChatModel _model = ChatModel.dummyData[index];
            return Container(
              color: Theme.of(context).accentColor,
              child: Column(
                children: <Widget>[
                  if (index != 0)
                    Divider(
                      height: 0.0,
                      indent: 10.0,
                      endIndent: 10.0,
                      thickness: 2.0,
                      color: Theme.of(context).backgroundColor,
                    ),
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
                        Text(
                          _model.name,
                          style: TextStyle(color: Color(0xFF101321)),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Text(
                          _model.datetime,
                          style: TextStyle(fontSize: 12.0, color: Color(0xFF101321)),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      _model.message,
                      style: TextStyle(color: Color(0xFF101321)),
                    ),
                    trailing: FlatButton.icon(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF101321),
                      ),
                      label: Text(" "),
                      //size: 14.0,
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => inChat()));
                      },
                    ),
                  ),
                  Divider(
                    height: 12.0,
                  ),
                ],
              ),
            );
          },
        ),

      ),
    );

  }
}
