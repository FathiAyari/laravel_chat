import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/message_widget.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen({Key? key}) : super(key: key);
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  List<MessageWidget> messages = [
    MessageWidget(receieved: true, id: 0),
    MessageWidget(receieved: false, id: 1),
    MessageWidget(receieved: true, id: 2),
    MessageWidget(receieved: false, id: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: Container(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      key: scaffoldKey,
      body: Scrollbar(
        thickness: 5,
        trackVisibility: true,
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            return messages[index];
          },
        ),
      ),
    ));
  }
}
