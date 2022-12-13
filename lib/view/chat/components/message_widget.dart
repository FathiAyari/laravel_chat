import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../ressources/colors/colors.dart';
import '../../../../../ressources/dimensions/dimensions.dart';

class MessageWidget extends StatefulWidget {
  bool receieved;
  int id;
  MessageWidget({Key? key, required this.receieved, required this.id}) : super(key: key);

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.withOpacity(0.3),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.01, vertical: Constants.screenHeight * 0.01),
            child: InkWell(
              onLongPress: () {},
              onTap: () {},
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/logooo.png"),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.015),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "SamehSamehSamehSameh ati",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(color: CustomColors.lightBlackColor, fontFamily: "RalewayBold"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Constants.screenWidth * 0.001, vertical: Constants.screenHeight * 0.01),
                                child: Text(
                                  "10:45",
                                  style:
                                      TextStyle(color: CustomColors.lightBlackColor.withOpacity(0.8), fontFamily: "RalewayBold"),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style:
                                      TextStyle(color: CustomColors.lightBlackColor.withOpacity(0.8), fontFamily: "RalewayBold"),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: Constants.screenWidth * 0.01),
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.red,
                                  child: Text("1"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
