import 'dart:io';

import 'package:auth/main.dart';
import 'package:auth/ressources/dimensions/dimensions.dart';
import 'package:auth/view/chat/search_friends_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../data/user.dart';
import '../authentication/signin/sign_in_screen.dart';
import '../components/alert_dialog.dart';
import 'components/message_widget.dart';
import 'messenger.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessagesScreen> {
  bool loading = false;
  List<MessageWidget> messages = [];
  var user = GetStorage().read("user");
  var storage = GetStorage();

  logOut() {
    storage.remove("auth");

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignInScreen()));
  }
  Future<bool> avoidReturnButton() async {
    Alerts.alertDialog(
        context,
        "Are you sure you want to exit ?",
        "assets/logooo.png",
            () {
          exit(0);
        },
        "Yes",
            () {
          Navigator.pop(context);
        },
        "No");
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: avoidReturnButton,child: SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.green,
                      child: CircleAvatar(
                        radius: 26,
                        backgroundImage: NetworkImage(user['avatar']),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${user['name']}",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.grey.withOpacity(0.5),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SearchFriendWidget()));
                              },
                              splashColor: Colors.grey,
                              highlightColor: Colors.grey,
                              child: SizedBox(
                                height: Constants.screenHeight * 0.06,
                                width: Constants.screenWidth * 0.12,
                                child: Icon(
                                  Icons.search,
                                ),
                              ),
                            ))),
                    PopupMenuButton<int>(
                      onSelected: (index) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Container(
                                  height: Constants.screenHeight * 0.2,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: Constants.screenHeight * 0.07),
                                        child: Text(
                                          "Are you sure you want to leave?",
                                          style: GoogleFonts.poppins(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("No"),
                                                  style: ElevatedButton.styleFrom(
                                                      primary: Colors.green
                                                          .withOpacity(0.8))),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    logOut();
                                                  },
                                                  child: Text("Yes"),
                                                  style: ElevatedButton.styleFrom(
                                                      primary: Colors.red
                                                          .withOpacity(0.8))),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: IconButton(
                        icon: Icon(
                          Icons.more_vert_sharp,
                          color: Colors.grey,
                        ),
                        onPressed: null,
                      ),
                      itemBuilder: (context) {
                        return <PopupMenuEntry<int>>[
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.logout),
                                Text("Logout"),
                              ],
                            ),
                            value: 0,
                          ),
                        ];
                      },
                    ),
                  ],
                ),
                height: Constants.screenHeight * 0.08,
                width: double.infinity,
              ),
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .orderBy('time')
                  .snapshots(),
              builder: (context, snapshot) {
                List msg = [];

                if (snapshot.hasData) {
                  if (snapshot.data!.size != 0) {
                    final messages = snapshot.data!.docs.reversed;
                    for (var message in messages) {
                      final getText = message.get('text');
                      final getSender = message.get('sender');
                      final getDestination = message.get('destination');
                      final getTime = message.get('time');
                      final getType = message.get('type');
                      final Map<String, dynamic> messageWidget = {
                        'getText': getText,
                        'getTime': DateFormat('kk:mm')
                            .format(DateTime.parse(getTime.toDate().toString())),
                        'getSender': getSender,
                        'getDestination': getDestination,
                        'getType': getType,
                      };
                      if ((((messageWidget["getSender"] == user['id']) ||
                          (messageWidget["getDestination"] == user['id'])))) {
                        msg.add(messageWidget);
                      }
                    }

                    for (int i = 0; i < msg.length; i++) {
                      for (int j = i + 1; j < msg.length; j++) {
                        if ((msg[i]["getSender"] == msg[j]["getSender"]) &&
                                (msg[i]["getDestination"] ==
                                    msg[j]["getDestination"]) ||
                            (msg[i]["getSender"] == msg[j]["getDestination"]) &&
                                (msg[i]["getSender"] ==
                                    msg[j]["getDestination"])) {
                          msg[j] = {
                            'getText': '',
                            'getSender': '',
                            'getDestination': '',
                          };
                        }
                      }
                    }

                    for (int i = 0; i < msg.length; i++) {
                      if (msg[i]["getSender"] == "") {
                        msg.remove(msg[i]);
                        i--;
                      }
                    }

                    if(msg.isNotEmpty){
                      return ListView.builder(
                        itemCount: msg.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.withOpacity(0.2)),
                            child: InkWell(
                              onTap: () async {
                                var destination = await FirebaseFirestore.instance
                                    .collection("users")
                                    .where(
                                  "id",
                                  isEqualTo: this.user['id'] ==
                                      msg[index]["getDestination"]
                                      ? msg[index]["getSender"]
                                      : msg[index]["getDestination"],
                                )
                                    .get();
                                var user = User.fromJson(destination.docs
                                    .toList()
                                    .first
                                    .data() as Map<String, dynamic>);


                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return Messenger(user: user,);
                                }));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                child: user['id'] == msg[index]["getSender"]
                                    ? Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 33,
                                        backgroundImage: NetworkImage(
                                            "${user["avatar"]}")),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              "You",
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    msg[index]["getType"]=="text"?  "${msg[index]["getText"]}":"you have sent  a photo",
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                      "${msg[index]["getTime"]}"),
                                                )
                                              ],
                                            )
                                          ],
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                                    : StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("users")
                                        .where('id',
                                        isEqualTo: msg[index]["getSender"])
                                        .snapshots(),
                                    builder: (BuildContext context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Row(
                                          children: [
                                            CircleAvatar(
                                                radius: 33,
                                                backgroundImage: NetworkImage(
                                                    "${snapshot.data!.docs[0].get('avatar')}")),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "${snapshot.data!.docs[0].get('name')}",
                                                      style:
                                                      GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            msg[index]["getType"]=="text"?  "${msg[index]["getText"]}":"you have received  a photo",

                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                              "${msg[index]["getTime"]}"),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      } else {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                    }),
                              ),
                            ),
                          );
                        },
                        padding: EdgeInsets.all(3),
                      );
                    }else{
                      return Column(
                        children: [
                          Lottie.asset("assets/empty.json"),
                          Text(
                            "No messages",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      );
                    }
                  } else
                    return Column(
                      children: [
                        Lottie.asset("assets/empty.json"),
                        Text(
                          "No messages",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ))
          ],
        ),
      )),
    );
  }
}
