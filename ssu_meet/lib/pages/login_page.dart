import 'dart:math' as math;
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double radians = 350 * math.pi / 180;

    final TextEditingController _studentIdController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

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
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.33,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.5,
                        child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/pink_yellow.png')),
                      )
                      // Positioned(
                      //   //left: screenWidth * 0.2,
                      //   right: screenWidth * 0.15,
                      //   top: screenHeight * -0.02,
                      //   bottom: screenHeight * -0.05,
                      //   child: Transform.rotate(
                      //     angle: radians,
                      //     child: Container(
                      //       width: screenWidth * 0.8,
                      //       height: screenWidth * 0.8,
                      //       child: Image(
                      //           fit: BoxFit.contain,
                      //           image: AssetImage(
                      //               'assets/images/post_it_with_tape/pink_tape.png')),
                      //     ),
                      //   ),
                      // ),
                      // Positioned(
                      //   //left: screenWidth * 0.2,
                      //   right: screenWidth * 0.04,
                      //   top: screenHeight * 0.01,
                      //   bottom: screenHeight * -0.1,
                      //   child: Container(
                      //     width: screenWidth * 0.8,
                      //     height: screenWidth * 0.8,
                      //     child: Image(
                      //         fit: BoxFit.contain,
                      //         image: AssetImage(
                      //             'assets/images/post_it_with_tape/yellow_tape.png')),
                      //   ),
                      // ),
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
                          controller: _studentIdController,
                          decoration: InputDecoration(
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
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 20),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: '유세인트 비밀번호',
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
                        width: screenWidth / 6 + 15,
                        height: 40,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.black,
                                side:
                                    const BorderSide(color: Color(0xff8E8E8E)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                elevation: 0),
                            onPressed: () {
                              print(_studentIdController.text);
                              print(_passwordController.text);
                            },
                            child: const Text(
                              "로그인",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
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
