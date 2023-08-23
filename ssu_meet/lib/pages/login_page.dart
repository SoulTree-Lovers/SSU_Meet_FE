import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ssu_meet/pages/responsive_page.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final TextEditingController studentIdController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

const storage = FlutterSecureStorage();
/* FlutterSecureStorage 사용법
  // Import plugin 
  import 'package:flutter_secure_storage/flutter_secure_storage.dart';

  // Create storage
  final _storage = const FlutterSecureStorage();

  // Read value
  String value = await _storage.read(key: key);

  // Read all values
  Map<String, String> allValues = await _storage.readAll();

  // Delete value
  await _storage.delete(key: key);

  // Delete all
  await _storage.deleteAll();

  // Write value
  await _storage.write(key: key, value: value);
  
  */

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double radians = 40 * math.pi / 180;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/paper_background.png'),
        ),
      ),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xffEFEFEF),
            elevation: 0,
          ),
          body: Column(
            children: [
              SizedBox(height: screenHeight * 0.03),
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.35,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: screenHeight * 0.4,
                      child: const Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/pink_yellow.png'),
                      ),
                    ),
                    Positioned.directional(
                      // right: screenWidth * 0.68,
                      bottom: screenHeight * 0.29,
                      start: screenHeight * 0.04,
                      end: screenHeight * 0.3,
                      textDirection: TextDirection.ltr,
                      child: SizedBox(
                        width: screenHeight * 0.07,
                        height: screenHeight * 0.07,
                        child: const Image(
                          fit: BoxFit.contain,
                          image: AssetImage('assets/images/heart.png'),
                        ),
                      ),
                    ),
                    Positioned.directional(
                      //left: screenWidth * 0.67,
                      bottom: screenHeight * 0.26,
                      start: screenHeight * 0.3,
                      end: screenHeight * 0.07,
                      textDirection: TextDirection.ltr,
                      child: Transform.rotate(
                        angle: radians * 0.75,
                        child: SizedBox(
                          width: screenHeight * 0.055,
                          height: screenHeight * 0.055,
                          child: const Image(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/images/heart.png'),
                          ),
                        ),
                      ),
                    ),
                    Positioned.directional(
                        //left: screenWidth * 0.8,
                        bottom: screenHeight * 0.08,
                        start: screenHeight * 0.35,
                        end: screenHeight * 0.01,
                        textDirection: TextDirection.ltr,
                        child: Transform.rotate(
                          angle: radians,
                          child: SizedBox(
                              width: screenHeight * 0.06,
                              height: screenHeight * 0.06,
                              child: const Image(
                                fit: BoxFit.contain,
                                image: AssetImage('assets/images/heart.png'),
                              )),
                        ))
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth,
                      //height: screenHeight * 0.59,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/rectangle.png'),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 55),
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 22,
                            color: Color(0xffA9A8A8),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Container(
                          margin: const EdgeInsets.only(left: 60, right: 60),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: studentIdController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(top: 20),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: '학번',
                              hintStyle: TextStyle(
                                  color: Color(0xffA9A8A8), fontSize: 14),
                              prefixIcon: Padding(
                                padding: EdgeInsets.fromLTRB(25, 15, 10, 15),
                                child: Icon(Icons.person_outline_rounded),
                              ),
                              prefixIconColor: Color(0xffA9A8A8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.only(left: 60, right: 60),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(top: 20),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: '유세인트 비밀번호',
                              hintStyle: const TextStyle(
                                color: Color(0xffA9A8A8),
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.fromLTRB(25, 15, 10, 15),
                                child: Icon(Icons.lock_outline_rounded),
                              ),
                              prefixIconColor: const Color(0xffA9A8A8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: screenWidth / 6 + 15,
                          height: 40,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.black,
                              side: const BorderSide(
                                color: Color(0xff8E8E8E),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              login().then(
                                (result) {
                                  if (result == 1) {
                                    // 개인정보등록화면으로 이동
                                    print("개인정보등록 화면으로 이동합니다.");
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            // const InputProfile(),
                                            const ResponsiveWebLayout(
                                          pageIndex: 1,
                                        ),
                                      ),
                                    );
                                  } else if (result == 2) {
                                    // 홈 화면으로 이동
                                    print("홈 화면으로 이동합니다.");
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ResponsiveWebLayout(
                                          pageIndex: 1,
                                        ),
                                      ),
                                    );
                                  } else {
                                    _showFailedToLoginDialog(context);
                                    print("로그인 실패");
                                    // 팝업 창 띄워주기
                                  }
                                },
                              );
                            },
                            child: const Text(
                              "로그인",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> login() async {
    // print("함수가 실행은 됐습니다.");
    const url = 'http://localhost:8080/v1/members/login';
    final data = MyData(studentIdController.text, passwordController.text);
    // print('Sending JSON payload: ${json.encode(data.toJson())}');
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data.toJson()),
    );
    print("데이터 전송");

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final isSuccess = responseData["status"];
      final message = responseData["message"];

      print(responseData);
      if (isSuccess == "SUCCESS") {
        await storage.write(
            key: "token", value: responseData["data"]["accessToken"]);
        //유세인트 인증에 성공한 경우
        print("유세인트 인증 성공");
        if (message == "Need new register") {
          print("개인정보등록이 필요합니다.");
          var token = await storage.read(key: "token");
          print("token: $token");
          return 1;
        } else if (message == "Main Ok") {
          print("이미 개인정보등록이 완료된 사용자입니다.");
          return 2;
        }
      } else {
        //유세인트 인증에 실패한 경우
        print("로그인 정보가 잘못되었습니다.");
        return 3; // 로그인 실패 (정보 오류)
      }
      // print('Received response: $result');
    } else {
      print('Failed to send data. Error: ${response.statusCode}');
      return 4; // 로그인 실패 (네트워크 에러)
    }
    return 0;
  }

  // 로그인을 실패하였을 경우 팝업 창
  void _showFailedToLoginDialog(BuildContext context) {
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
            '로그인에 실패하였습니다. \n',
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
}

class MyData {
  final String studentNumber;
  final String password;

  MyData(this.studentNumber, this.password);

  Map<String, dynamic> toJson() => {
        'studentNumber': studentNumber,
        'password': password,
      };
}

// Future<void> sendData() async {
//   print("함수가 실행은 됐습니다.");
//   const url = 'http://localhost:8080/v1/members/login';
//   final data = MyData(studentIdController.text, passwordController.text);
//   print('Sending JSON payload: ${json.encode(data.toJson())}');
//   final response = await http.post(
//     Uri.parse(url),
//     headers: {'Content-Type': 'application/json'},
//     body: json.encode(data.toJson()),
//   );
//   print("데이터 전송");

//   if (response.statusCode == 200) {
//     final responseData = json.decode(response.body);
//     final isSuccess = responseData["status"];

//     if (isSuccess == "SUCCESS") {
//       //유세인트 인증에 성공한 경우
//       print("유세인트 인증 성공");
//     } else {
//       //유세인트 인증에 실패한 경우
//       print("로그인 정보가 잘못되었습니다.");
//     }
//     // print('Received response: $result');
//   } else {
//     print('Failed to send data. Error: ${response.statusCode}');
//   }
// }
