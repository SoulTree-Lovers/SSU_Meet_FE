import 'package:flutter/material.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({
    super.key,
  });

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "나만의 슝슝이를 찾아보자 !",
            style: TextStyle(
              fontFamily: "Ongeul",
              fontSize: 30,
            ),
          ),
          backgroundColor: Colors.blue[100],
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
