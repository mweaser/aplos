import 'package:aplos/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final Icon icon;
  final double height;
  final double width;
  final double fontSize;

  const TextFieldInput(
      {Key? key,
      required this.textEditingController,
      this.isPass = false,
      required this.hintText,
      required this.textInputType,
      required this.icon,
      this.height = 61,
      this.width = 382,
      this.fontSize = 26})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
        borderSide: BorderSide(width: 3, color: secondaryColor),
        borderRadius: BorderRadius.circular(10));

    return Container(
      height: height,
      width: width,
      child: TextField(
        style: TextStyle(
          fontSize: fontSize,
          color: whiteColor,
          fontWeight: FontWeight.w600,
        ),
        controller: textEditingController,
        decoration: InputDecoration(
          fillColor: secondaryColor,
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 10, right: 18),
            child: icon,
          ),
          hintStyle: TextStyle(
            fontSize: fontSize,
            color: whiteColor,
            fontWeight: FontWeight.w600,
          ),
          hintText: hintText,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.only(top: 40),
        ),
      ),
    );
  }
}
