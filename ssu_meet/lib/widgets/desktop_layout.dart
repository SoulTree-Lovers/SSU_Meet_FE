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
        color: Colors.blue[100],
        child: const Center(
          child: Text(
            '>>>>>>>>>> 창 크기를 줄여줘 <<<<<<<<<<',
            style: TextStyle(
              fontSize: 50,
              fontFamily: "Nanum_2",
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
