import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ssu_meet/pages/info_page.dart';
import 'package:ssu_meet/pages/login_page.dart';
import 'package:ssu_meet/pages/my_page.dart';
import 'package:ssu_meet/pages/main_page.dart';

import 'package:http/http.dart' as http;

class ResponsiveWebLayout extends StatefulWidget {
  final int pageIndex;
  const ResponsiveWebLayout({super.key, required this.pageIndex});

  @override
  State<ResponsiveWebLayout> createState() =>
      _ResponsiveWebLayoutState(pageIndex: pageIndex);
}

class _ResponsiveWebLayoutState extends State<ResponsiveWebLayout> {
  int pageIndex;

  _ResponsiveWebLayoutState({required this.pageIndex});

  // int _selectedIndexScreen = 1; // Main Page

  int coins = 0;
  // int coins = getCoin();

  // 서버에서 코인 가져오기
  void getCoinFromServer() async {
    const url = 'http://43.202.77.44:8080/v1/members/mycoin';
    var token = await storage.read(key: "token");

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // 한글 깨짐 현상 해결: utf8.decode(response.bodyBytes)를 사용하여 입력받기
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));

      if (responseData["status"] == "SUCCESS") {
        setState(() {
          coins = responseData["data"]["myCoinCount"];
          print("서버에서 코인 가져옴 ! 현재 코인 개수: $coins");
        });
      } else {
        // Error
        print("Status is Error !!");
      }
    } else {
      // Network error
      print('Failed to get data. Error: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCoinFromServer();
  }

  final List _children = [
    const InfoPage(),
    const MainPage(),
    const MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
        shadowColor: const Color.fromRGBO(158, 156, 156, 1),
        flexibleSpace: Padding(
          padding: EdgeInsets.only(right: screenWidth * 0.03),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.05, top: screenWidth * 0.005),
                  child: Container(
                    width: screenWidth * 0.17,
                    height: screenHeight * 0.04,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/images/ssu_meet_logo.png",
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenWidth * 0.23,
                  height: screenWidth * 0.06,
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
                        padding: EdgeInsets.all(screenWidth * 0.002),
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
      ),
      body: _children[pageIndex],
      // body: LayoutBuilder(
      //   builder: (BuildContext context, BoxConstraints constraints) {
      //     if (constraints.maxWidth <= 600) {
      //       // Layout for iPhone-sized screens
      //       // return const HomePage();
      //       return const TestMainPage();
      //     } else {
      //       // Layout for computer screens
      //       return const DesktopLayout();
      //     }
      //   },

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
        selectedItemColor: const Color.fromRGBO(24, 24, 27, 1),
        unselectedItemColor: const Color.fromARGB(255, 114, 113, 113),
        currentIndex: pageIndex,
        onTap: (int index) {
          setState(() {
            pageIndex = index;
            getCoinFromServer();
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                "assets/images/info_page_icon.png",
              ),
            ),
            label: "설명서",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                "assets/images/home_page_icon.png",
              ),
            ),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                "assets/images/my_page_icon.png",
              ),
            ),
            label: "마이페이지",
          ),
        ],
      ),
    );
  }
}

// 서버에서 코인 개수 가져오기 (임시)
int getCoin() {
  return 3;
}
