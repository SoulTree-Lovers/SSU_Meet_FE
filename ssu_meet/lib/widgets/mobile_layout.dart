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
        body: GridView.builder(
          shrinkWrap: true,
          itemCount: 100,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
            childAspectRatio: 1 / 1, //item 의 가로 1, 세로 1 의 비율
            mainAxisSpacing: 10, //수평 Padding
            crossAxisSpacing: 10, //수직 Padding
          ),
          itemBuilder: (BuildContext context, int index) {
            // return Text(index.toString());
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                ),
                child: Text("$index"),
              ),
            );
          },
        ),
      ),
    );
  }
}
