import 'dart:html';
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
              image: AssetImage('assets/images2/paper.png'))),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: const Color(0xffEFEFEF),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.33,
                  child: Stack(
                    children: [
                      Positioned(
                          right: screenWidth / 4 + 40,
                          bottom: screenHeight / 100 - 40,
                          child: Transform.rotate(
                            angle: radians,
                            child: const Image(
                                image: AssetImage(
                                    'assets/images/green_post_it.png')),
                          )),
                      Positioned(
                          width: 50,
                          height: 40,
                          right: screenWidth / 4 + 135,
                          top: screenHeight / 100 + 27,
                          child: Transform.rotate(
                            angle: radians,
                            child: const Image(
                                image: AssetImage('assets/images/tape1.png')),
                          )),
                      Positioned(
                          right: screenWidth / 4,
                          bottom: screenHeight / 100 - 60,
                          child: const Image(
                              image: AssetImage(
                                  'assets/images/yellow_post_it.png'))),
                      Positioned(
                          width: 50,
                          height: 50,
                          right: screenWidth / 4 + 83,
                          top: screenHeight / 100 + 45,
                          child: const Image(
                              image: AssetImage('assets/images/tape2.png')))
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
