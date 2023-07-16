import 'dart:math' as math;
import 'package:flutter/material.dart';

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
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.33,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 130,
                        top: -30,
                        child: Transform.rotate(
                          angle: radians,
                          child: const Image(
                              image: AssetImage(
                                  'assets/images/green_post_it.png')),
                        ),
                      ),
                      Positioned(
                        left: 200,
                        top: 25,
                        child: Transform.rotate(
                          angle: radians,
                          child: const Image(
                            width: 60,
                            height: 60,
                            image: AssetImage('assets/images/tape1.png'),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 160,
                        top: 0,
                        child: const Image(
                            image:
                                AssetImage('assets/images/yellow_post_it.png')),
                      ),
                      Positioned(
                        left: 240,
                        top: 60,
                        child: const Image(
                            width: 60,
                            height: 60,
                            image: AssetImage('assets/images/tape2.png')),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   width: screenWidth,
                //   height: screenHeight * 0.33,
                //   child: Stack(
                //     alignment: Alignment.center,
                //     children: [
                //       Positioned.fill(
                //           right: 40,
                //           //bottom: 30,
                //           child: Align(
                //             alignment: Alignment.topCenter,
                //             child: Transform.rotate(
                //               angle: radians,
                //               child: const Image(
                //                   image: AssetImage(
                //                       'assets/images/green_post_it.png')),
                //             ),
                //           )),
                //       Positioned.fill(
                //           right: 60,
                //           top: 40,
                //           child: Align(
                //             alignment: Alignment.topCenter,
                //             child: Container(
                //               width: 45,
                //               height: 40,
                //               child: Transform.rotate(
                //                 angle: radians,
                //                 child: const Image(
                //                     image:
                //                         AssetImage('assets/images/tape1.png')),
                //               ),
                //             ),
                //           )),
                //       Positioned.fill(
                //           left: 40,
                //           child: Align(
                //             alignment: Alignment.topCenter,
                //             child: const Image(
                //                 image: AssetImage(
                //                     'assets/images/yellow_post_it.png')),
                //           )),
                //       Positioned.fill(
                //           left: 40,
                //           top: 50,
                //           child: Align(
                //             alignment: Alignment.topCenter,
                //             child: Container(
                //               width: 50,
                //               height: 40,
                //               child: const Image(
                //                   image: AssetImage('assets/images/tape2.png')),
                //             ),
                //           ))
                //     ],
                //   ),
                // ),
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
                        child: const TextField(
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
                            onPressed: () {},
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