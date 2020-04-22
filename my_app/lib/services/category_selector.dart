import 'package:flutter/material.dart';
import 'package:my_app/common/color.dart';

class CategorySelector extends StatefulWidget {
  @override
  _CategorySelectorState createState() => _CategorySelectorState();

}

class _CategorySelectorState extends State<CategorySelector> {

  int selectedIndex = 0;
  final List<String> categories = ['Requests','Donation'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      color: accentColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Text(
              categories[index], 
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                ))
          );
        }
      )
    );
  }
}