import 'package:intl/intl.dart';
import 'user.dart';

class Message {
  final User sender;
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