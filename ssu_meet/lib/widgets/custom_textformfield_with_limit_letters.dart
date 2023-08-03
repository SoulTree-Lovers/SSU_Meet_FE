import 'package:flutter/material.dart';

class MyFormField extends StatefulWidget {
  final String hintText;
  final double screenWidth;
  final FormFieldValidator? validator;
  final FormFieldSetter? onSaved;
  final int maxLength;
  final int? maxLine;

  const MyFormField({
    Key? key,
    required this.hintText,
    required this.screenWidth,
    required this.maxLength,
    required this.maxLine,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  State<MyFormField> createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      maxLines: widget.maxLine,
      maxLength: widget.maxLength,
      cursorWidth: 1.5,
      cursorHeight: widget.screenWidth * 0.04,
      cursorColor: Colors.transparent,
      style: TextStyle(
        fontSize: widget.screenWidth * 0.035,
        fontFamily: "Nanum_Ogbice",
        color: Colors.black,
      ),
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: widget.screenWidth * 0.02),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: widget.screenWidth * 0.04,
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black, width: widget.screenWidth * 0.0015),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black, width: widget.screenWidth * 0.0015),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
            width: widget.screenWidth * 0.0015,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: widget.screenWidth * 0.0015,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: widget.screenWidth * 0.0015,
          ),
        ),
      ),
      validator: widget.validator,
      onSaved: widget.onSaved,
      controller: _textController,
      onChanged: (text) {
        if (text.length > widget.maxLength) {
          // 최대 글자 수를 넘으면 입력을 막습니다.
          _textController.text = text.substring(0, widget.maxLength);
          _textController.selection = TextSelection.fromPosition(
            TextPosition(offset: _textController.text.length),
          );
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
