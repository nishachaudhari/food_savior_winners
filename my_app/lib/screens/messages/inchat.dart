import 'package:flutter/material.dart';
import 'package:my_app/models/user.dart';
import 'package:provider/provider.dart';





class inChat extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {

    User user = Provider.of<User>(context);


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
                      IconButton(
                          icon: Icon(Icons.face), onPressed: () {}),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Type Something...",
                              border: InputBorder.none),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.photo_camera),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.attach_file),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: 15),
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Colors.teal, shape: BoxShape.circle),
                child: InkWell(
                  child: Icon(
                    Icons.keyboard_voice,
                    color: Colors.white,
                  ),
                  onLongPress: () {

                  },
                ),
              )
            ],
          ),

      ),
      
    );

  }
}
