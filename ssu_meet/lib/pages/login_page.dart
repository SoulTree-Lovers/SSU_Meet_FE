import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ssu_meet/pages/responsive_page.dart';

final TextEditingController studentIdController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double radians = 350 * math.pi / 180;

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
                SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.33,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.5,
                        child: const Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/pink_yellow.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 1),
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
                            topRight: Radius.circular(50)
                          ),
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
                                print(studentIdController.text);
                                print(passwordController.text);
                
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ResponsiveWebLayout(pageIndex: 1),
                                  ),
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
}

class MyData {
  final String studentId;
  final String pw;

  MyData(this.studentId, this.pw);

  Map<String, dynamic> toJson() => {
        'studentId': studentId,
        'pw': pw,
      };
}

Future<void> sendData() async {
  print("함수가 실행은 됐습니다.");
  const url = 'http://localhost:8010/jsoup';
  final data = MyData(studentIdController.text, passwordController.text);
  print('Sending JSON payload: ${json.encode(data.toJson())}');
  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(data.toJson()),
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    final result =
        responseData; // result 값은 유세인트 인증 여부에 따라 true or false 값으로 bool형태로 받음
    if (result) {
      //유세인트 인증에 성공한 경우
      print("유세인트 인증 성공");
    } else {
      //유세인트 인증에 실패한 경우
      print("로그인 정보가 잘못되었습니다.");
    }
    // print('Received response: $result');
  } else {
    print('Failed to send data. Error: ${response.statusCode}');
  }
}
