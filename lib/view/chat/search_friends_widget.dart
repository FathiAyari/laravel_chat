import 'package:auth/main.dart';
import 'package:auth/ressources/dimensions/dimensions.dart';
import 'package:auth/view/authentication/signin/components/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchFriendWidget extends StatefulWidget {
  const SearchFriendWidget({Key? key}) : super(key: key);

  @override
  State<SearchFriendWidget> createState() => _SearchFriendWidgetState();
}

class _SearchFriendWidgetState extends State<SearchFriendWidget> {
  TextEditingController nameController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),

      body: Column(children: [
        Container(

          child: InputField(
              fillColor: primaryColor.withOpacity(0.2),
              controller:nameController , label: "Taper le nom d'utilisateur", prefixWidget: Icon(Icons.account_circle), textInputType: TextInputType.text),
        )
      ],),
    );
  }
}
