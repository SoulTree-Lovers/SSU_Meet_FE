import 'package:flutter/material.dart';
import 'package:ssu_meet/dialogs/input_post_it_dialog.dart';

Positioned RegistrationButtonBlack(
    double screenHeight, double screenWidth, BuildContext context) {
  return Positioned(
    top: screenHeight * 0.7,
    left: screenWidth * 0.65,
    child: GestureDetector(
      onTap: () {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return const InputPostIt();
            });
        print("등록하기 버튼 클릭 !");
      },
      child: Container(
        width: screenWidth * 0.3,
        height: screenHeight * 0.07,
        decoration: ShapeDecoration(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Color(
                0x3F000000,
              ),
            ),
            borderRadius: BorderRadius.circular(45),
          ),
        ),
        child: Center(
          child: Text(
            "+ 등록하기",
            style: TextStyle(
              fontFamily: "Ongeul",
              fontSize: screenWidth * 0.07,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}
