import 'package:flutter/material.dart';

void alertRequiredInput(BuildContext context) {
  showDialog(
      barrierColor: Colors.white.withOpacity(0.7),
      context: context,
      builder: (BuildContext context) => AlertDialog(
          contentPadding: const EdgeInsets.only(
              top: 30, left: 30, right: 30, bottom: 10),
          actionsPadding: const EdgeInsets.only(bottom: 25),
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1.5,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Color(0xFF020202),
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          shadowColor: const Color(0x3F000000),
          content: Container(
            width: 300,
            height: 55,
            alignment: Alignment.center,
            child: const Text(
              '필수 조건을 모두 입력해주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'NanumSquareRoundBold',
                // fontWeight: FontWeight.w700,
                // height: 1.31,
              ),
            )
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Container(
                  width: 70,
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black,
                  ),
                  child: const Center(
                    child: Text(
                      "확인",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'NanumSquareRoundR',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]));
}
