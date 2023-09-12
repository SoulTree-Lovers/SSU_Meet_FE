import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

TextSpan getTextSpan(LinkTextItem item, double screenWidth) {
  if (item.isLink) {
    return TextSpan(
      text: item.text,
      style: TextStyle(
        height: 1.5,
        color: Colors.black,
        fontSize: screenWidth * 0.025,
        decoration: TextDecoration.underline,
        fontFamily: "NanumSquareAc",
        fontWeight: FontWeight.w700,
      ),
      recognizer: TapGestureRecognizer()..onTap = item.onTap,
    );
  } else {
    return TextSpan(
        text: item.text,
        style: TextStyle(
          height: 1.5,
          color: Colors.black,
          fontSize: screenWidth * 0.025,
          fontFamily: "NanumSquareAc",
          fontWeight: FontWeight.w700,
        ));
  }
}

class LinkTextItem {
  String text; // 보여질 텍스트
  bool isLink; // 링크 유무
  Function()? onTap; //링크 클릭 시 이벤트

  LinkTextItem({
    required this.text,
    this.isLink = false,
    this.onTap,
  });
}
