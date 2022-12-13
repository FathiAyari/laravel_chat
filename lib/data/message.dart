import 'package:auth/data/user.dart';

class Message {
  final String content;
  final User sender;
  final User receiver;
  DateTime dateTime;

  Message({required this.content, required this.sender, required this.receiver, required this.dateTime});
}
