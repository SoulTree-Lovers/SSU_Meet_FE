import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ssu_meet/my_page/modify_information.dart';
import 'package:ssu_meet/my_page/view_registered.dart';
import 'package:ssu_meet/pages/login_page.dart';
import 'package:ssu_meet/pages/purchased_post_it_page.dart';
import 'package:ssu_meet/pages/responsive_page.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  static List<String> mypageMenuText = [
    "등록한 포스트잇",
    "구입한 포스트잇",
    "기본 정보 수정",
    "로그아웃"
  ];
  static List<String> mypageIcon = [
    "assets/images/mypage_images/registered.png",
    "assets/images/mypage_images/purchased.png",
    "assets/images/mypage_images/modify.png",
    "assets/images/mypage_images/logout.png"
  ];

  final List _mypageMenu = [
    const ViewRegistered(),
    const PurchasedPostItPage(),
    const ModifyPage(),
    //const LogoutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 540) {
      //태블릿 사이즈 레이아웃 설정
      screenWidth *= 0.8;
    }
    return Scaffold(
        backgroundColor: const Color(0xffD8D8D8),
        // appBar: AppBar(
        //   backgroundColor: const Color(0xffEFEFEF),
        //   elevation: 0.0,
        //   title: Text("마이페이지"),
        // ),
        body: Column(
          children: [
            const SizedBox(height: 6),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 5, right: 5),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(
                            left: screenWidth * 0.09, right: screenWidth * 0.1),
                        title: Container(
                          alignment: Alignment.centerLeft,
                          height: screenWidth * 0.13,
                          child: Text(
                            mypageMenuText[index],
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.035,
                              fontFamily: 'NanumSquare_ac',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.26,
                            ),
                          ),
                        ),
                        leading: Container(
                          alignment: Alignment.centerLeft,
                          width: screenWidth * 0.07,
                          height: screenWidth * 0.11,
                          child: Image.asset(
                            mypageIcon[index],
                            fit: BoxFit.contain,
                          ),
                        ),
                        trailing: Container(
                          width: screenWidth * 0.07,
                          height: screenWidth * 0.09,
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.chevron_right,
                            size: screenWidth * 0.05,
                          ),
                        ),
                        onTap: () {
                          // if(index==2) return LoadingModifyPage().getOldProfile(context);
                          if (index == 3) {
                            return logoutDialog(context);
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => _mypageMenu[index],
                              ),
                            );
                          }
                          print(mypageMenuText[index]);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: screenWidth * 1.5,
              height: screenHeight * 0.08,
              decoration: const BoxDecoration(
                color: Color(0xFFEFEFEF),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "문의사항",
                    style: TextStyle(
                      color: const Color.fromARGB(150, 0, 0, 0),
                      fontSize: screenWidth * 0.025,
                    ),
                  ),
                  Text(
                    "rkdtmdals999@naver.com",
                    style: TextStyle(
                      color: const Color.fromARGB(150, 0, 0, 0),
                      fontSize: screenWidth * 0.025,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

void logoutDialog(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;

  showDialog(
    barrierColor: Colors.white.withOpacity(0.7),
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding:
            const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 25),
        actionsPadding: const EdgeInsets.only(bottom: 30),
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1.5,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: Color(0xFF020202),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        shadowColor: const Color(0x3F000000),
        content: const Text(
          '로그아웃 하시겠습니까?',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontFamily: 'NanumSquareRoundBold',
            // fontWeight: FontWeight.w700,
            // height: 1.31,
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 70,
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Text(
                      "취소",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF010101),
                        fontSize: 10,
                        fontFamily: 'NanumSquareRoundR',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  // 저장되어 있던 토큰 모두 삭제
                  storage.deleteAll();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ResponsiveWebLayout(
                        pageIndex: 1,
                      ),
                    ),
                  );
                },
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
            ],
          ),
        ],
      );
    },
  );
}
