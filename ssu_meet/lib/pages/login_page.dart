import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
              image: AssetImage('assets/images/paper_background.png'))),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: const Color(0xffEFEFEF),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.33,
                  child: Stack(
                    //alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 110,
                        right: 150,
                        top: -35,
                        // bottom: 0,
                        child: Align(
                          alignment: Alignment.center,
                          child: Transform.rotate(
                            angle: radians,
                            child: const Image(
                                image: AssetImage(
                                    'assets/images/green_post_it.png')),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 195,
                        right: 250,
                        top: 20,
                        //bottom: 140,
                        child: Align(
                          alignment: Alignment.center,
                          child: Transform.rotate(
                            angle: radians,
                            child: const Image(
                              width: 60,
                              height: 60,
                              image: AssetImage('assets/images/tape1.png'),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 160,
                        right: 100,
                        top: -20,
                        //bottom: -45,
                        child: Align(
                          alignment: Alignment.center,
                          child: Image(
                              image: AssetImage(
                                  'assets/images/yellow_post_it.png')),
                        ),
                      ),
                      const Positioned(
                        left: 250,
                        right: 190,
                        top: 40,
                        //bottom: 140,
                        child: Align(
                          alignment: Alignment.center,
                          child: Image(
                              width: 60,
                              height: 60,
                              image: AssetImage('assets/images/tape2.png')),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 1),
                Stack(children: [
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.66,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/rectangle.png'))),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 55),
                      const Text(
                        "Login",
                        style:
                            TextStyle(fontSize: 22, color: Color(0xffA9A8A8)),
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
                              )
                            ]),
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
                              )
                            ]),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 20),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: '비밀번호',
                            hintStyle: const TextStyle(
                                color: Color(0xffA9A8A8), fontSize: 14),
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
                        width: screenWidth / 6 + 10,
                        height: 35,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                side:
                                    const BorderSide(color: Color(0xff8E8E8E)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                elevation: 0),
                            onPressed: () {
                              sendData();
                              print(studentIdController.text);
                              print("\n");
                              print(passwordController.text);
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff8E8E8E)),
                            )),
                      ),
                    ],
                  )
                ])
              ],
            ),
          )),
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
  const url = 'http://localhost:8010/data';
  final data = MyData(studentIdController.text, passwordController.text);
  print('Sending JSON payload: ${json.encode(data.toJson())}');
  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(data.toJson()),
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    final result = responseData;

    print('Received response: $result');
  } else {
    print('Failed to send data. Error: ${response.statusCode}');
  }
}
