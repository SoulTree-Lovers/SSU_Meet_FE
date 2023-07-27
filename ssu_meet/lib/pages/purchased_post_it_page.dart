import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssu_meet/pages/responsive_page.dart';
import 'package:ssu_meet/widgets/main_page_post_it.dart';

class PurchasedPostItPage extends StatefulWidget {
  const PurchasedPostItPage({super.key});

  @override
  State<PurchasedPostItPage> createState() => _PurchasedPostItPageState();
}

class _PurchasedPostItPageState extends State<PurchasedPostItPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    int coins = getCoin();
    // int selectedIndexScreen = 0; // Main Page

    // final List children = [
    //   PurchasedPostItBody(screenHeight, screenWidth),
    //   const InfoPage(),
    //   const MainPage(),
    //   const MyPage(),
    // ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
        shadowColor: const Color.fromRGBO(158, 156, 156, 1),
        flexibleSpace: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: screenWidth * 0.2,
                height: screenWidth * 0.05,
                decoration: BoxDecoration(
                  color: const Color(0xFFD7D7D7),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth * 0.03,
                      height: screenWidth * 0.03,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/currency_dollar.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "보유 코인: $coins",
                        style: TextStyle(
                          color: const Color(0xFF1A1A1A),
                          fontFamily: "NanumSquareRoundBold",
                          fontSize: screenWidth * 0.025,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: PurchasedPostItBody(screenHeight, screenWidth),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
      //   selectedItemColor: const Color.fromRGBO(24, 24, 27, 1),
      //   unselectedItemColor: const Color.fromARGB(255, 114, 113, 113),
      //   currentIndex: selectedIndexScreen,
      //   onTap: (int index) {
      //     setState(() {
      //       selectedIndexScreen = index;
      //     });
      //   },
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: ImageIcon(
      //         AssetImage(
      //           "assets/images/info_page_icon.png",
      //         ),
      //       ),
      //       label: "설명서",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: ImageIcon(
      //         AssetImage(
      //           "assets/images/home_page_icon.png",
      //         ),
      //       ),
      //       label: "홈",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: ImageIcon(
      //         AssetImage(
      //           "assets/images/my_page_icon.png",
      //         ),
      //       ),
      //       label: "마이페이지",
      //     ),
      //   ],
      // ),
    );
  }

  Container PurchasedPostItBody(double screenHeight, double screenWidth) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/images/paper_background.png',
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Container(
                    width: 15,
                    height: 15,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/images/chevron_down.png",
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "구입한 포스트잇",
                    style: TextStyle(
                      color: Color(0xFF707070),
                      fontFamily: "NanumSquareAc",
                      fontSize: 15,
                      letterSpacing: 0.30,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: getPurchasedPostItData(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the future is not yet completed
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // If an error occurred
                  return Text('Error: ${snapshot.error}');
                } else {
                  // If the future completed successfully
                  return MainPagePostIt(
                    screenHeight,
                    snapshot,
                    screenWidth,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<List> getPurchasedPostItData() async {
  // 서버에서 포스트잇 앞면 데이터 가져오기
  String jsonString =
      await rootBundle.loadString('json/purchased_post_it_json.json');
  final jsonResponse = json.decode(jsonString);

  return jsonResponse;
}
