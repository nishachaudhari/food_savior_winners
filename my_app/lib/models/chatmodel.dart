
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatModel {
  String avatarUrl;
  String name;
  String datetime;
  String message;
  String id;
  String foodID;


  ChatModel({this.avatarUrl, this.name, this.datetime, this.message, this.id, this.foodID});
}