import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssu_meet/my_page/registered_dialog.dart';

import 'package:http/http.dart' as http;
import 'package:ssu_meet/pages/login_page.dart';

class ViewRegistered extends StatelessWidget {
  const ViewRegistered({super.key});

  // API 연동 (등록한 포스트잇 가져오기)
  Future<dynamic> getRegisteredStickyData() async {
    const url = 'http://localhost:8080/v1/members/mypage/sticky-list';
    var token = await storage.read(key: "token");

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      final message = responseData["message"];

      // 등록한 포스트잇 가져오기 성공
      if (message == "ExistRegisterPostIt") {
        return responseData["data"]["stickyData"];
      } else {
        print("등록한 포스트잇이 없습니다.");
        return [];
      }
    } else {
      print("Failed to get data. Error: ${response.statusCode}");
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // return const Text("test");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
        shadowColor: const Color.fromRGBO(158, 156, 156, 1),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left,
                color: Color(0xff717171), size: 30)),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/paper_background.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.keyboard_arrow_down,
                        color: Color(0xff717171), size: 30),
                    Text(
                      "등록한 포스트잇",
                      style: TextStyle(
                        color: Color(0xff717171),
                        fontWeight: FontWeight.w600,
                        fontFamily: "NanumSquareAc",
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 25),
                FutureBuilder(
                  // future: getRegisteredPostItData(),
                  future: getRegisteredStickyData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 30,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            print("index: $index");
                            var postIt = snapshot.data![index];
                            var id = postIt["stickyId"];
                            var isSold = postIt["isSold"];

                            var nickname = postIt["stickyData"]["nickname"];
                            var hobbies = postIt["stickyData"]["hobbies"];
                            var mbti = postIt["stickyData"]["mbti"];
                            var introduction =
                                postIt["stickyData"]["introduce"];
                            var ideals = postIt["stickyData"]["ideals"];

                            Widget isSoldPostIt() {
                              if (isSold == 1) {
                                return const Image(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage('assets/images/is_sold.png'),
                                );
                              } else {
                                return const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/images2/yellowpostit2.png',
                                  ),
                                );
                              }
                            }

                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => RegisteredDialog(
                                    nickname: nickname,
                                    hobbies: hobbies,
                                    mbti: mbti,
                                    introduction: introduction,
                                    ideals: ideals,
                                  ),
                                );
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: screenWidth * 0.35,
                                    height: screenWidth * 0.5,
                                    child: isSoldPostIt(),
                                  ),
                                  Positioned(
                                    child: SizedBox(
                                      width: screenWidth * 0.2,
                                      height: screenWidth * 0.3,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "닉네임: $nickname",
                                              style: TextStyle(
                                                fontFamily: "Nanum_Ogbice",
                                                fontSize: screenWidth * 0.03,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 7),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "취미: ",
                                                  style: TextStyle(
                                                    fontFamily: "Nanum_Ogbice",
                                                    fontSize:
                                                        screenWidth * 0.03,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "${hobbies[0]}",
                                                    textAlign: TextAlign.left,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Nanum_Ogbice",
                                                      fontSize:
                                                          screenWidth * 0.03,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 7),
                                            Text(
                                              "MBTI: $mbti",
                                              style: TextStyle(
                                                fontFamily: "Nanum_Ogbice",
                                                fontSize: screenWidth * 0.03,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 7),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "소개: ",
                                                  style: TextStyle(
                                                    fontFamily: "Nanum_Ogbice",
                                                    fontSize:
                                                        screenWidth * 0.03,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "$introduction",
                                                    textAlign: TextAlign.left,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Nanum_Ogbice",
                                                      fontSize:
                                                          screenWidth * 0.03,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<List> getRegisteredPostItData() async {
  String response =
      await rootBundle.loadString('json/test_registered_post_it_json.json');
  final jsonData = json.decode(response);

  return jsonData["data"]["stickyData"];
}
