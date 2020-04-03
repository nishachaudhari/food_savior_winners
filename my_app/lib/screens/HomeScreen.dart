import 'package:flutter/material.dart';
import 'package:my_app/screens/foodInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:my_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:my_app/screens/mapIcon.dart';
import 'package:geolocator/geolocator.dart';


class HomeScreen extends StatefulWidget
{
  @override
  State <StatefulWidget> createState()
  {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State <HomeScreen>
    with SingleTickerProviderStateMixin {
   Position _currentPosition;
   String _currentAddr;

   _getCurrentLocation() async {
      final currentPosition  = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
       setState(() {
        _currentPosition = currentPosition;
        });
        _getAddressFromLatLng();
      }

   _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await Geolocator().placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddr =
            "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}";
      });
    }
    catch (e) {
      print(e);
    }
   }

   AnimationController _controller;

   @override
   void initState() {
     super.initState();
     _controller = AnimationController(
       duration: const Duration(seconds: 10),
       vsync: this,
     )..repeat();
   }

   Animatable<Color> background = TweenSequence<Color>([
     TweenSequenceItem(
       weight: 1.0,
       tween: ColorTween(
         begin: Colors.red,
         end: Colors.green,
       ),
     ),
     TweenSequenceItem(
       weight: 1.0,
       tween: ColorTween(
         begin: Colors.green,
         end: Colors.blue,
       ),
     ),
     TweenSequenceItem(
       weight: 1.0,
       tween: ColorTween(
         begin: Colors.blue,
         end: Colors.pink,
       ),
     ),
   ]);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    void _showDialog(){
      showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: new Text("Select a Food to get more Information!"),
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


    final pics =   Container(
       child: StreamBuilder(
         stream: Firestore.instance.collection('food').snapshots(),
         builder: (context, snapshot){
           if(!snapshot.hasData) return Text('loading data .... please wait');
          int length = snapshot.data.documents.length;

          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              Uint8List bytes = base64Decode(snapshot.data.documents[index]['photo']);
              if (snapshot.data.documents[index]['user']!= user.uid)
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => foodInfo(index)),
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      Card(
                        color: Colors.grey[300],
                        margin: EdgeInsets.all(15.0),
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                //color: Colors.white,
                                height: 50,
                                width: 400,
                                child:
                                  FlatButton(
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => foodInfo(index)),
                                      );
                                    },
                                    splashColor: Colors.blueGrey,
                                    child: Text(snapshot.data.documents[index]['title'], style: TextStyle(color:Colors.green[600], fontSize: 30)),
                                  )
                              ),
                              Image.memory(bytes)
                            ],
                          )
                        )
                      ),
                      // Overlay tooltip for food option
                      if (index == 0)
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child){
                            return Container(
                              alignment: Alignment.center,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size.height / 2,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(width: 16, color: Colors.pink[600]),
                                        left: BorderSide(width: 16, color: Colors.pink[600]),
                                        right: BorderSide(width: 16, color: Colors.pink[600]),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 40,
                                    color: background
                                      .evaluate(AlwaysStoppedAnimation(_controller.value)),
                                    child: Text(
                                      "Tap the food to get more information!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            );
                          }
                        )
                    ],
                  ),
                );
              else return Container();
            },
            itemCount: snapshot.data.documents == null ? 0:length,
          );
         }
       )
     );

    return Scaffold(
       appBar: AppBar(
         centerTitle: false,
         title: Text("Pick Up"),
         backgroundColor: Colors.green,
           actions: <Widget>[
             IconButton(
               icon: Icon(Icons.search),
               onPressed: (){
                 showSearch(context: context,delegate: Datasearch());
               }),
               IconButton(
               icon: Icon(Icons.explore),
               onPressed: (){
                 Navigator.push(context,
                 MaterialPageRoute(builder: (context) => mapIcon()));
               })
           ],
       ),

       body:
       Container (
         child: Column (
       children: <Widget>[
           SizedBox (height: 10,),
           Text("Your Current Location:", style: TextStyle(fontSize: 20)),
           if (_currentPosition != null)
              Text( _currentAddr, style: TextStyle(fontSize: 20)),
            FlatButton(
              child: Text("Update Current location"),
              onPressed: () {
                _getCurrentLocation();
              },
            ),

           Expanded(
            child: SizedBox(
              height: 200.0,
              child: pics
                )
            )
          ],

         )
       )
    );
   }



}


   class Datasearch extends SearchDelegate<String> {
     final foodCategories = [
       "Mexican",
       "Thai",
       "Vegan",
       "Fish",
       "dog",
       "donkey",
       "dove",
       "Chinese",
       "Indian",
       "Deli",

     ];
     final foodCategoriesRecent = [
       "Chinese",
       "Indian",
       "Deli",
     ];
     @override
     List<Widget> buildActions(BuildContext conext){
         return [IconButton(icon: Icon(Icons.clear),onPressed: (){
           query = "";
         })];
     }

     @override
     Widget buildLeading(BuildContext context){
       return IconButton(
         icon: AnimatedIcon(
           icon: AnimatedIcons.menu_arrow,
             progress: transitionAnimation,
             ),
             onPressed: (){
               close(context, null);
             });
     }
     @override
     Widget buildResults(BuildContext context){
         return Container(
           height:100.0,
           width: 100.0,
           child: Card(
           color: Colors.green,
           shape: StadiumBorder(),
           child:Center(
             child: Text(query),
             ),
         ),
         );
     }

     @override
     Widget buildSuggestions(BuildContext context)
     {
       final suggestionList = query.isEmpty ? foodCategoriesRecent : foodCategories.where((p)=> p.startsWith(query)).toList();

       return ListView.builder(
         itemBuilder: (context, index) => ListTile(
           onTap: (){
             showResults(context);
           },
           leading: Icon(Icons.location_city),
             title: RichText(
               text: TextSpan(
                 text: suggestionList[index].substring(0,query.length),
                   style: TextStyle(
                     color: Colors.black,fontWeight: FontWeight.bold),
                     children: [
                       TextSpan(
                         text: suggestionList[index].substring(query.length),
                         style: TextStyle(color: Colors.green))

                     ]
                 ),
                 ),
             ),

           itemCount: suggestionList.length,
         );
       }
     }
