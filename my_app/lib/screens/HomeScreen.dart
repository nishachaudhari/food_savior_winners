import 'package:flutter/material.dart';



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

   
    final label = Center(
        child: Padding (
          padding: const EdgeInsets.all(36.0),
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text('Home Screen', style: TextStyle(color:Colors.green, fontSize: 20, fontWeight: FontWeight.bold) ),
          SizedBox(height:15),
         // logoutButton,
          ]
        ) 
       ),
      );

    return Scaffold(
       appBar: AppBar(
         title: Text(""),
         backgroundColor: Colors.green,
           actions: <Widget>[
             IconButton(
               icon: Icon(Icons.search),
               onPressed: (){
                 showSearch(context: context,delegate: Datasearch());
               })
           ],
       ),

       body: label,
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


