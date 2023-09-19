import 'package:flutter/material.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({
    super.key,
  });

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        color: Colors.white,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '현재 해상도는 지원하지 않습니다.',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: "NanumSquareRoundBold",
                  color: Colors.black,
                ),
              ),
              Text(
                '>> 화면의 너비를 줄여주세요 <<',
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "NanumSquareRoundBold",
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
