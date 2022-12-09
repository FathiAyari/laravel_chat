import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../ressources/dimensions/dimensions.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
final String label;
final Widget prefixWidget;
final TextInputType textInputType;
  const InputField({Key? key, required this.controller, required this.label, required this.prefixWidget, required this.textInputType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: Constants.screenHeight * 0.001, horizontal: Constants.screenWidth * 0.07),
      child: Container(
        height: Constants.screenHeight * 0.09,
        child: TextFormField(
          style: TextStyle(fontSize: 18),
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "Required field";
            } else if (label == "E-mail") {
              bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
              if (!emailValid) {
                return " wrong mail format ";
              }
            }
          },
          keyboardType: textInputType,
          cursorColor: Colors.black,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            prefixIcon: prefixWidget,
            hintText: label,
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
