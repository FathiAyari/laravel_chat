import 'package:flutter/material.dart';

import '../../ressources/dimensions/dimensions.dart';

class Alerts {
  static alertDialog(
    BuildContext context,
    String message,
    String image,
    VoidCallback posPress,
    String posMessage,
    VoidCallback negPress,
    String negMessage,
  ) {
    return showDialog(
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: Constants.screenHeight * 0.2,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                      top: -Constants.screenHeight * 0.05,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          image,
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: Constants.screenHeight * 0.06),
                    child: Column(
                      children: [
                        Expanded(
                          child: Text(
                            message,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: Constants.screenHeight * 0.01),
                                child: ElevatedButton(
                                    onPressed: posPress,
                                    child: Text(
                                      posMessage,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(primary: Colors.pink)),
                              )),
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: Constants.screenHeight * 0.01),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(primary: Colors.green),
                                    onPressed: negPress,
                                    child: Text(
                                      negMessage,
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        context: context);
  }
}
