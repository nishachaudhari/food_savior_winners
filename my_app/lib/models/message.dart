import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'user.dart';

class Message {
  final UserData sender;
  final DateTime time;
  final String text;
  final bool isLiked;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.isLiked,
    this.unread,
  });

}
