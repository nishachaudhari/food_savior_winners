import 'package:flutter/material.dart';

class Request{
  final String user;
  final String eater;
  final String foodID;
  final String status; //accepted or denied or pending
  
  
 // var tags = new List(10);


  Request({ this.user,this.eater, this.foodID, this.status});

}