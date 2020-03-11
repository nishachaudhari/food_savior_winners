import 'package:flutter/material.dart';
import 'package:my_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:typed_data';


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

  @override
  Widget build(BuildContext context) {

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
               })
           ],
       ),

       body: 
       StreamBuilder(
         stream: Firestore.instance.collection('food').snapshots(),
         builder: (context, snapshot){
           if(!snapshot.hasData) return Text('loading data .... please wait');
          int length = snapshot.data.documents.length;

          return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
              Uint8List bytes = base64Decode(snapshot.data.documents[index]['photo']);
           return Card(
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
                  child: Text(snapshot.data.documents[index]['title'], style: TextStyle(color:Colors.green[600], fontSize: 30)),
                ),
                Image.memory(bytes)
             ],
           )
             )
           );
          },
        itemCount: snapshot.data.documents == null ? 0:length,
          );
         }  
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


