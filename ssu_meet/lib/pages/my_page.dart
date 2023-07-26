import 'package:flutter/material.dart';
import 'package:ssu_meet/my_page/logout.dart';
import 'package:ssu_meet/my_page/modify_information.dart';
import 'package:ssu_meet/my_page/view_purchased.dart';
import 'package:ssu_meet/my_page/view_registered.dart';

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
    const ViewPurchased(),
    const ModifyPage(),
    const LogoutPage()
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffD8D8D8),
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text("마이페이지"),
      // ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.25,
              //padding: EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Image(
                      image: AssetImage(
                        'assets/images/mypage_images/mypage_profile.png',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 140,
                        height: 33,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD7D7D7),
                          ),
                          child: const Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "assets/images/mypage_images/coin_icon.png"),
                                ),
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Text(
                                "보유 코인 : 3개",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontFamily: 'NanumSquareRound',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Container(
                        width: 140,
                        height: 33,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD7D7D7),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                // child: Icon(
                                //   Icons.content_copy,
                                //   color: Color(0xff18181B),

                                // ),
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    "assets/images/mypage_images/my_post_it_icon.png",
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "나의 포스트잇 : 3개",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontFamily: 'NanumSquareRound',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: screenWidth,
              height: 260,
              decoration: const BoxDecoration(
                color: Color(0xFFEFEFEF),
              ),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 1.2,
                  );
                },
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.only(left: 50, right: 35),
                    title: Container(
                      alignment: Alignment.centerLeft,
                      height: 44,
                      child: Text(
                        mypageMenuText[index],
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: 'NanumSquare_ac',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.26,
                        ),
                      ),
                    ),
                    leading: SizedBox(
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        mypageIcon[index],
                        fit: BoxFit.contain,
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => _mypageMenu[index],
                        ),
                      );
                      print(mypageMenuText[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
