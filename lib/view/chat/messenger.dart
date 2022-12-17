import 'dart:io';

import 'package:auth/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../data/user.dart';

final snapshotMessages = FirebaseFirestore.instance;
ScrollController controller = new ScrollController();

class Messenger extends StatefulWidget {
  final User user;

  const Messenger({required this.user});

  @override
  _MessengerState createState() => _MessengerState();
}

class _MessengerState extends State<Messenger> {
  String textMessage = "";
  File? _image;
  bool doneImage = false;
  bool startUpload = false;

  Future sendImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (image?.path != null) {
      setState(() {
        _image = File(image!.path);
        doneImage = true;
      });
    }

    ;
  }

  bool isShowSticker = false;
  bool showKeyBoard = false;
  var focusNode = FocusNode();
  var inputFlex = 1;
  var numLines;
  bool startType = false;

  ScrollController controller = new ScrollController();
  TextEditingController messageController = new TextEditingController();
  @override
  var currentUser = GetStorage().read("user");

  updateStartTypeStatus(bool value) {
    if (startType != value) {
      startType = value;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.green,
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage("${widget.user.avatar}"),
                ),
              ),
              SizedBox(
                width: size.width * 0.01,
              ),
              Text(
                "${widget.user.name}",
                style: TextStyle(
                    fontSize: size.height * 0.028,
                    fontFamily: "NewsCycle-Bold"),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Column(
              children: [
                MessageStreamBuilder(
                  receiverId: widget.user.id!,
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: TextField(
                            controller: messageController,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                updateStartTypeStatus(false);
                              } else {
                                updateStartTypeStatus(true);
                              }
                            },
                            cursorColor: Colors.black,
                            style: TextStyle(
                              height: 1.7,
                            ),
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 5,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(2),
                              filled: true,
                              hintText: "Ecrir un message",
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 200),
                            transitionBuilder: (Widget child,
                                    Animation<double> animation) =>
                                ScaleTransition(child: child, scale: animation),
                            child: startType
                                ? Container(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                        onPressed: () {
                                          snapshotMessages
                                              .collection('messages')
                                              .add({
                                            'text': "${messageController.text}",
                                            'destination': widget.user.id,
                                            'sender': currentUser['id'],
                                            'time': DateTime.now(),'type':"text"
                                          }).then((value) {
                                            messageController.clear();
                                            updateStartTypeStatus(false);
                                          });
                                        },
                                        icon: Icon(Icons.send)))
                                : Container(
                                    alignment: Alignment.center,
                                    child: IconButton(
                                        onPressed: () {
                                          sendImage();
                                        },
                                        icon: Icon(Icons.image)))),
                      )
                    ],
                  ),
                ),
              ],
            ),
            doneImage
                ? Container(
                    width: double.infinity,
                    color: Colors.grey.withOpacity(0.9),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.file(
                          _image!,
                          fit: BoxFit.fill,
                        ),
                        FloatingActionButton(
                          onPressed: startUpload
                              ? null
                              : ()async {
                                  setState(() {
                                    startUpload = true;
                                  });
                                  var image = FirebaseStorage
                                      .instance // instance
                                      .ref(_image!
                                      .path); //ref=> esm de fichier fel storage
                                  var task =
                                  image.putFile(_image!);
                                  var imageUrl =
                                  await (await task) // await 1: attendre l'upload d'image dans firestorage,2await: attendre la recuperation de lien getDownloadURL
                                      .ref
                                      .getDownloadURL().then((value) {
                                    snapshotMessages
                                        .collection('messages')
                                        .add({
                                      'text': "${value}",
                                      'destination': widget.user.id,
                                      'sender': currentUser['id'],
                                      'time': DateTime.now(),
                                      'type':"image",

                                    }).then((value) {
                                    setState(() {
                                      startUpload=false;
                                      doneImage=false;

                                    });
                                    });
                                  });
                                },
                          child: Icon(Icons.send),
                        ),
                        Positioned(
                            top: 0,
                            left: 0,
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        doneImage = false;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    )))),
                        startUpload
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container()
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class MessageLine extends StatefulWidget {
  final String getText;
  final String getType;
  final int getSender;
  final int getDestination;
  final DateTime getTime;
  final bool check;

  const MessageLine({
    required this.getText,
    required this.getType,
    required this.getSender,
    required this.getDestination,
    required this.check,
    required this.getTime,
  });

  @override
  _MessageLineState createState() => _MessageLineState();
}

class _MessageLineState extends State<MessageLine> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment:
            widget.check ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: widget.check
                ? BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15))
                : BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
            color: widget.check ? Color(0xff5a40a1) : Color(0xffe6ebf5),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.getType=="text"?
                  Text(
                    "${widget.getText}",
                    style: TextStyle(
                        fontSize: 20,
                        color: widget.check ? Colors.white : Colors.black),
                  ):Image.network("${widget.getText}"),
                  Text(
                    "${DateFormat('kk:mm').format(widget.getTime)}",
                    style: TextStyle(
                        fontSize: 10,
                        color: widget.check ? Colors.white : Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//tous les messages
class MessageStreamBuilder extends StatefulWidget {
  final int receiverId;

  const MessageStreamBuilder({
    required this.receiverId,
  });

  @override
  _MessageStreamBuilderState createState() => _MessageStreamBuilderState();
}

class _MessageStreamBuilderState extends State<MessageStreamBuilder> {
  var currentUser = GetStorage().read("user");

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          snapshotMessages.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MessageLine> msg = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        for (var message in messages) {
          final getText = message.get('text');
          final getType = message.get('type');
          final getSender = message.get('sender');
          final getDestination = message.get('destination');
          final getTime = message.get("time").toDate();

          if ((getSender == currentUser['id'] &&
                  getDestination == widget.receiverId) ||
              (getSender == widget.receiverId &&
                  getDestination == currentUser['id'])) {
            final messageWidget = MessageLine(
              getText: getText,
              getType: getType,
              getSender: getSender,
              getDestination: getDestination,
              check: currentUser['id'] == getSender ? true : false,
              getTime: getTime,
            );

            msg.add(messageWidget);
          }
        }
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          controller.animateTo(controller.position.minScrollExtent,
              duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        }); //scroll to the end of listview
        return Expanded(
            child: ListView(
          reverse: true,
          padding: EdgeInsets.all(20),
          controller: controller,
          children: msg,
        ));
      },
    );
  }
}
