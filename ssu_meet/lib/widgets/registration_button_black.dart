import 'package:flutter/material.dart';
import 'package:ssu_meet/pages2/input_post_it_dialog.dart';

Positioned RegistrationButtonBlack(double screenHeight, double screenWidth,BuildContext context) {
  return Positioned(
    top: screenHeight * 0.7,
    left: screenWidth * 0.7,
    child: GestureDetector(
      onTap: () {
        showDialog(
          barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {return InputPostIt(); });
        print("등록하기 버튼 클릭 !");
      },
      child: Container(
        width: 90,
        height: 40,
        decoration: ShapeDecoration(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Color(
                0x3F000000,
              ),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Center(
          child: Text(
            "+ 등록하기",
            style: TextStyle(
              fontFamily: "Ongeul",
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}
