import 'package:auth/main.dart';
import 'package:auth/ressources/dimensions/dimensions.dart';
import 'package:auth/view/chat/search_friends_widget.dart';
import 'package:auth/view/chat/start_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/message_widget.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessagesScreen> {
  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool loading = false;
  List<MessageWidget> messages = [
    MessageWidget(receieved: true, id: 0),
    MessageWidget(receieved: false, id: 1),
    MessageWidget(receieved: true, id: 2),
    MessageWidget(receieved: false, id: 3),
  ];
  var user = GetStorage().read("user");
  var storage=GetStorage();
  Future<void> logOut()async {
setState(() {
  loading=true;
});
    storage.remove(user);
    storage.remove("auth");

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(

          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          key: scaffoldKey,
          body: Stack(
            children: [
              Scrollbar(
                thickness: 5,
                trackVisibility: true,
                child: Column(
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
                                            builder: (context) =>
                                                SearchFriendWidget()));
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
                                showDialog(context: context, builder: (context){
                                  return Dialog(
                                    child: Container(
                                      height: Constants.screenHeight *0.2,
                                      color: Colors.white,
                                      child: Column(children: [
                                        Padding(
                                          padding:  EdgeInsets.only(top: Constants.screenHeight*0.07),
                                          child: Text("Are you sure you want to leave?",  style: GoogleFonts.poppins(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),),
                                        ),
                                        Spacer(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ElevatedButton(

                                                    onPressed: (){

                                                      Navigator.pop(context);
                                                    }, child: Text("No"),style: ElevatedButton.styleFrom(
                                                    primary: Colors.green.withOpacity(0.8)
                                                )),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ElevatedButton(

                                                    onPressed: (){}, child: Text("Yes"),style: ElevatedButton.styleFrom(
                                                    primary: Colors.red.withOpacity(0.8)
                                                )),
                                              ),
                                            ),

                                          ],)
                                      ],),
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
                      child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return messages[index];
                        },
                      ),
                    ),
                  ],
                ),
              ),
              loading
                  ? Container(
                child: Center(
                  child: Container(
                    decoration:
                    BoxDecoration(color: primaryColor.withOpacity(0.3), borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                color: Colors.white.withOpacity(0.3),
              )
                  : Container()
            ],
          ),
        ));
  }
}
