import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyFormField extends StatelessWidget {
  final String hintText;
  final double screenWidth;
  final FormFieldValidator? validator;
  final FormFieldSetter? onSaved;
  final String? initText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;

  const MyFormField({
    Key? key,
    required this.hintText,
    required this.screenWidth,
    required this.textInputAction,
    this.initText,
    this.validator,
    this.onSaved,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      cursorWidth: 1.5,
      cursorHeight: screenWidth * 0.04,
      cursorColor: Colors.black,
      style: TextStyle(
        fontFamily: "Nanum_Ogbice",
        fontSize: screenWidth * 0.05,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.fromLTRB(0,10,0,5),
        errorStyle: TextStyle(
          fontSize: 0.03 * screenWidth,
          fontFamily: "Nanum_Ogbice",
          color: const Color.fromRGBO(255, 0, 0, 1),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: screenWidth * 0.04,
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: screenWidth * 0.0015,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: screenWidth * 0.0015,
          ),
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
      inputFormatters: inputFormatters,
      textInputAction: textInputAction,
    );
  }
}
