import 'dart:convert';

import 'package:auth/main.dart';
import 'package:auth/view/authentication/signin/components/input_field.dart';
import 'package:auth/view/chat/components/friend_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../../data/user.dart';
import '../../ressources/dimensions/dimensions.dart';
import '../../services/auth_services/call_api_dart.dart';

class SearchFriendWidget extends StatefulWidget {
  const SearchFriendWidget({Key? key}) : super(key: key);

  @override
  State<SearchFriendWidget> createState() => _SearchFriendWidgetState();
}

class _SearchFriendWidgetState extends State<SearchFriendWidget> {
  TextEditingController nameController = TextEditingController();
  var user = GetStorage().read('user');
  List<User> result = [];
  List<User> users = [];
  late bool loading = false;
  getUsers() async {
    setState(() {
      loading = true;
    });
    var response = await CallApi().getData('users/${user['id']}');
    var results = jsonDecode(response.body);
    print(results);
    List<User> listOfUsers = [];
    for (var data in results) {
      listOfUsers.add(User.fromJson(data));
    }
    setState(() {
      users = listOfUsers;
      result = users;
      loading = false;
    });
  }

  filterData() {
    if (nameController.text != "") {
      List<User> filtered = [];
      for (var user in users) {
        if (user.name!.toLowerCase().contains(nameController.text.toLowerCase())) {
          filtered.add(user);
        }
      }
      setState(() {
        result = filtered;
      });
    } else {
      setState(() {
        result = users;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.addListener(() {
      filterData();
    });

    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getUsers();
        },
        child: Column(
          children: [
            InputField(
                fillColor: primaryColor.withOpacity(0.2),
                controller: nameController,
                label: "Type the name of user",
                prefixWidget: Icon(Icons.account_circle),
                textInputType: TextInputType.text),
            loading
                ? Expanded(child: Center(child: Lottie.asset("assets/loading.json", height: Constants.screenHeight * 0.1)))
                : (result.isEmpty
                    ? Center(
                        child: Column(
                        children: [
                          Lottie.asset("assets/empty.json"),
                          Text(
                            "Sorry  there is no user yet ",
                            style: TextStyle(fontSize: 20, fontFamily: "NunitoBold", color: Colors.black.withOpacity(0.5)),
                          )
                        ],
                      ))
                    : Expanded(
                        child: ListView.builder(
                            itemCount: result.length,
                            itemBuilder: (context, index) {
                              return FriendWidget(user: result[index]);
                            })))
          ],
        ),
      ),
    );
  }
}
