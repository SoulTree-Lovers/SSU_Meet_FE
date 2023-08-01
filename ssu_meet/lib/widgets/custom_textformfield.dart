import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  final String hintText;
  final double screenWidth;
  final FormFieldValidator? validator;
  final FormFieldSetter? onSaved;
  final String? initText;

  const MyFormField({
    Key? key,
    required this.hintText,
    required this.screenWidth,
    this.initText,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      cursorWidth: 1.5,
      cursorHeight: screenWidth * 0.03,
      cursorColor: Colors.black,
      style: TextStyle(
        fontSize: screenWidth * 0.05,
        fontFamily: "Nanum_Ogbice",
        color: Colors.black,
      ),
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: screenWidth * 0.02),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: screenWidth * 0.04,
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black, width: screenWidth * 0.0015),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black, width: screenWidth * 0.0015),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: screenWidth * 0.0015,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: screenWidth * 0.0015,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: screenWidth * 0.0015,
          ),
        ),
      ),
      validator: validator,
      onSaved: onSaved,
      initialValue: initText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}