import 'package:auth/view/chat/messenger.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/user.dart';
import '../../../main.dart';
import '../../../ressources/dimensions/dimensions.dart';

class FriendWidget extends StatefulWidget {
  final User user;
  const FriendWidget({Key? key, required this.user}) : super(key: key);

  @override
  State<FriendWidget> createState() => _FriendWidgetState();
}

class _FriendWidgetState extends State<FriendWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Messenger(user: widget.user)));
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(color: primaryColor.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.green,
                child: CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(widget.user.avatar!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${widget.user.name!}",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          height: Constants.screenHeight * 0.08,
          width: double.infinity,
        ),
      ),
    );
  }
}
