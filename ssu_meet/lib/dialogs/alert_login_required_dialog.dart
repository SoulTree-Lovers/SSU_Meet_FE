import 'package:flutter/material.dart';
import 'package:ssu_meet/pages/login_page.dart';

void alertLoginRequired(BuildContext context) {
  showDialog(
    barrierColor: Colors.white.withOpacity(0.7),
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding:
            const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
        actionsPadding: const EdgeInsets.only(bottom: 30),
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
        content:  Container(
          width: 250,
          height: 55,
          alignment: Alignment.center,
          child: const Text(
            '로그인 후 이용할 수 있습니다.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'NanumSquareRoundBold',
              // fontWeight: FontWeight.w700,
              // height: 1.31,
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shadowColor: Colors.black26,
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                  fixedSize: const Size(70, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  "취소",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "NanumSquareRoundR",
                    fontSize: 10,
                    //fontWeight: FontWeight.w500
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(
                    left: 0,
                    right: 0,
                  ),
                  backgroundColor: Colors.black,
                  shadowColor: Colors.black26,
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                  fixedSize: const Size(70, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  "로그인 하기",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "NanumSquareRoundR",
                    fontSize: 10,
                    //fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
