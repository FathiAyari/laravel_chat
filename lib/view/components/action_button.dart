import 'package:auth/ressources/dimensions/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String label;

  const ActionButton(
      {Key? key,
      required this.onPressed,
      required this.color,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Constants.screenHeight * 0.09,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Constants.screenHeight * 0.01,
            horizontal: Constants.screenWidth * 0.04),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            onPressed: onPressed,
            child: Text(
              label,
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
