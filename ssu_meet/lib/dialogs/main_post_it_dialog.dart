import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ssu_meet/pages/login_page.dart';
import 'package:ssu_meet/pages/responsive_page.dart';
import 'package:http/http.dart' as http;

class MainPostItDialog extends StatefulWidget {
  final int stickyId;
  final String nickname;
  final int age;
  final String major;
  final String mbti;
  final int height;
  final List hobbies;
  final String introduce;
  final String? instaId;
  final String? kakaoId;
  final String? phoneNumber;
  final List ideals;

  const MainPostItDialog({
    required this.stickyId,
    required this.nickname,
    required this.age,
    required this.major,
    required this.mbti,
    required this.height,
    required this.hobbies,
    required this.introduce,
    required this.instaId,
    required this.kakaoId,
    required this.phoneNumber,
    required this.ideals,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPostItDialog();
}

class _MainPostItDialog extends State<MainPostItDialog> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      backgroundColor: Colors.transparent,
      // Set the background color to transparent
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage(
                      "assets/images/images2/yellowpostit2.png",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: screenWidth * 0.2,
                left: screenWidth * 0.15,
                child: SizedBox(
                  height: screenHeight * 0.4,
                  width: screenWidth * 0.6,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "닉네임: ${widget.nickname}",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "나이: ${widget.age}살",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "학과: ${widget.major}",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "MBTI: ${widget.mbti}",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "키: ${widget.height}cm",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "취미 1: ${widget.hobbies.isNotEmpty ? widget.hobbies[0] : 'x'}",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        Text(
                          "취미 2: ${widget.hobbies.length >= 2 ? widget.hobbies[1] : 'x'}",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        Text(
                          "취미 3: ${widget.hobbies.length >= 3 ? widget.hobbies[2] : 'x'}",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "자기소개: ${widget.introduce}",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "이상형:",
                              style: TextStyle(
                                fontFamily: "Nanum_Ogbice",
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.43,
                              height: screenWidth * 0.1,
                              child: SingleChildScrollView(
                                child: Wrap(
                                  children: widget.ideals.map((item) {
                                    return Container(
                                      width: screenWidth * 0.12,
                                      height: screenWidth * 0.04,
                                      margin: EdgeInsets.fromLTRB(
                                        screenWidth * 0.01,
                                        screenWidth * 0.01,
                                        screenWidth * 0.01,
                                        0,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: screenWidth * 0.001,
                                        ),
                                        color: Colors.transparent,
                                      ),
                                      child: Center(
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            fontFamily: "Nanum_Ogbice",
                                            fontSize: screenWidth * 0.025,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showBuyDialog(context, widget.stickyId);
                  // _showCompletedBuyingDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    screenWidth * 0.3,
                    screenWidth * 0.1,
                  ),
                  side: const BorderSide(color: Colors.black, width: 0.5),
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
                ),
                child: Text(
                  "구매하기",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04,
                    fontFamily: "Nanum_Ogbice",
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    screenWidth * 0.3,
                    screenWidth * 0.1,
                  ),
                  side: const BorderSide(color: Colors.black, width: 0.5),
                  backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                  shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
                ),
                child: Text(
                  "닫기",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.04,
                    fontFamily: "Nanum_Ogbice",
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 메인화면 포스트잇 클릭 후 구매 버튼 클릭 시 팝업 창
  void _showBuyDialog(BuildContext context, int stickyId) async {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
          content: const Text(
            '구매를 진행하시면 코인 1개가 차감됩니다. \n구매하시겠습니까? \n',
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
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    final purchaseSuccess = await buyPostIt(stickyId);
                    print("purchase success: $purchaseSuccess");
                    // 구매 성공 시
                    if (purchaseSuccess == 1) {
                      print("구매를 성공하였습니다.");
                      _showCompletedBuyingDialog(context);
                    }

                    // 이미 팔린 포스트잇인 경우
                    else if (purchaseSuccess == 2) {
                      print("이미 팔린 포스트잇입니다.");
                      _showSoldOutDialog(context);
                    }

                    // 코인이 부족할 경우
                    else if (purchaseSuccess == 3) {
                      print("코인이 부족합니다.");
                      _showNotEnoughCoinDialog(context);
                    }

                    // 토큰을 보유하지 않은 사용자
                    else if (purchaseSuccess == "GoToLoginPage") {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    }
                    // 네트워크 에러
                    else {
                      print("포스트잇 구매 에러 발생");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shadowColor: Colors.black26,
                      side: const BorderSide(
                        color: Colors.black,
                      ),
                      fixedSize: const Size(70, 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )),
                  child: const Text(
                    "구매하기",
                    style: TextStyle(
                      color: Colors.white,
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
                      )),
                  child: const Text(
                    "취소",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "NanumSquareRoundR",
                      fontSize: 9,
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

  // 포스트잇 구매 api
  Future<dynamic> buyPostIt(int stickyId) async {
    // print("함수가 실행은 됐습니다.");
    var url = 'http://54.180.20.191:8080/v1/sticky/buy/$stickyId';
    // 디바이스에 저장된 access token과 refresh token 읽어오기 (존재하지 않으면 null 리턴)
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      return "GoToLoginPage";
    }
    // print('Sending JSON payload: ${json.encode(data.toJson())}');
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    print("데이터 전송");
    final responseData = jsonDecode(utf8.decode(response.bodyBytes));
    final isSuccess = responseData["status"];
    final message = responseData["message"];

    if (response.statusCode == 200) {
      // print(responseData);
      if (isSuccess == "SUCCESS") {
        // 포스트잇 구매 성공한 경우
        // print("포스트잇 구매 성공");
        return 1;
      } else {
        if (message == "AlreadySold") {
          // print("이미 판매된 포스트잇입니다.");
          return 2;
        } else {
          // print("코인이 부족합니다.");
          return 3;
        }
      }
      // print('Received response: $result');
    } else if (response.statusCode == 401) {
      // 엑세스 토큰이 만료되었거나, 유효하지 않은 경우
      if (message == "Token has expired") {
        // 엑세스 토큰이 만료된 경우
        final isSuccessNewToken =
            await getNewAccessToken(); // 리프레시 토큰으로 엑세스 토큰 재발급
        if (isSuccessNewToken == "NewAccessToken") {
          // 엑세스 토큰을 정상적으로 재발급 받은 경우
          return await buyPostIt(stickyId); // 포스트잇 구매 함수 재실행
        } else if (isSuccessNewToken == "storageDelete") {
          // 리프레시 토큰이 만료된 경우
          return "GoToLoginPage";
        } else if (isSuccessNewToken == "tokenError") {
          // 리프레시 토큰이 에러가 발생한 경우
          return "GoToLoginPage";
        } else {
          // 네트워크 에러 또는 토큰 재발급 함수 자체에 에러가 발생한 경우
          return "GoToLoginPage";
        }
      } else {
        // 엑세스 토큰이 유효하지 않은 경우 및 그 외 예외
        await storage.deleteAll(); // 저장되어 있던 토큰 모두 삭제
        return "GoToLoginPage";
      }
    } else {
      print('Failed to send data. Error: ${response.statusCode}');
      return 4; // 로그인 실패 (네트워크 에러)
    }
  }

  // 포스트잇 구매 완료 시 팝업 창
  void _showCompletedBuyingDialog(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
          content: const Text(
            '포스트잇 구매가 완료되었습니다. \n확인하시겠습니까? \n',
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ResponsiveWebLayout(
                          pageIndex: 1,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(
                      left: 0,
                      right: 0,
                    ),
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
                    "더 둘러보기",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "NanumSquareRoundR",
                      fontSize: 9,
                      //fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ResponsiveWebLayout(
                          pageIndex: 2,
                        ),
                      ),
                    );
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
                    "마이페이지 이동",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "NanumSquareRoundR",
                      fontSize: 9,
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

  // 이미 팔린 포스트잇인 경우 팝업 창
  void _showSoldOutDialog(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
          content: const Text(
            '이미 판매된 포스트잇입니다. \n',
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
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ResponsiveWebLayout(
                        pageIndex: 1,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shadowColor: Colors.black26,
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                    fixedSize: const Size(70, 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                child: const Text(
                  "확인",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "NanumSquareRoundR",
                    fontSize: 10,
                    //fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // 코인이 부족할 경우 팝업 창
  void _showNotEnoughCoinDialog(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
          content: const Text(
            '코인이 부족합니다. \n',
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
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shadowColor: Colors.black26,
                    side: const BorderSide(
                      color: Colors.black,
                    ),
                    fixedSize: const Size(70, 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                child: const Text(
                  "확인",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "NanumSquareRoundR",
                    fontSize: 10,
                    //fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
