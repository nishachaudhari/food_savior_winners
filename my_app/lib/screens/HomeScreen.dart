
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:my_app/common/app_card.dart';
import 'package:my_app/common/app_card.dart';
import 'package:my_app/services/auth.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';

class HomeScreen extends StatelessWidget{

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final logoutButton = Material(
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


    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                showSearch(context: context,delegate: Datasearch());
              })
          ],
      ),
     
      body: Center(
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
      ),
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
          color: Colors.red,
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
  
  







