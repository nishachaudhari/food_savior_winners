
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatModel {
  final String avatarUrl;
  final String name;
  final String datetime;
  final String message;


  ChatModel({this.avatarUrl, this.name, this.datetime, this.message});
}