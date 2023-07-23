import 'package:flutter/material.dart';

Positioned RegistrationButton(double screenHeight, double screenWidth) {
  return Positioned(
    top: screenHeight * 0.7,
    left: screenWidth * 0.7,
    child: GestureDetector(
      onTap: () {
        print("등록하기 버튼 클릭 !");
      },
      child: Container(
        width: 90,
        height: 40,
        decoration: ShapeDecoration(
          color: Colors.white.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFF010101)),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Center(
          child: Text(
            "+ 등록하기",
            style: TextStyle(
              fontFamily: "Ongeul",
              fontSize: 20,
            ),
          ),
        ),
      ),
    ),
  );
}
