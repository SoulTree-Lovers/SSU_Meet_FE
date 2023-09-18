import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssu_meet/my_page/registered_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:ssu_meet/pages/login_page.dart';

class ViewRegistered extends StatefulWidget {
  const ViewRegistered({super.key});

  @override
  State<ViewRegistered> createState() => _ViewRegisteredState();
}

class _ViewRegisteredState extends State<ViewRegistered> {
  bool isRegistered = true;

  // API 연동 (등록한 포스트잇 가져오기)
  Future<dynamic> getRegisteredStickyData() async {
    const url = 'https://ssumeet.shop/v1/members/mypage/sticky-list';
    // 디바이스에 저장된 access token과 refresh token 읽어오기 (존재하지 않으면 null 리턴)
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      // 미등록 사용자
      isRegistered = false;
      return [];
    }

    // setState(() {
    //   isRegistered = true; // 등록된 사용자임을 검증
    // });

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Access-Control-Allow-Origin': '*',
      },
    );

    final responseData = jsonDecode(utf8.decode(response.bodyBytes));
    final message = responseData["message"];

    if (response.statusCode == 200) {
      // 등록한 포스트잇 가져오기 성공
      if (message == "ExistRegisterPostIt") {
        return responseData["data"]["stickyData"];
      } else {
        // print("등록한 포스트잇이 없습니다.");
        return [];
      }
    } else if (response.statusCode == 401) {
      // 엑세스 토큰이 만료되었거나, 유효하지 않은 경우
      if (message == "Token has expired") {
        // 엑세스 토큰이 만료된 경우
        final isSuccessNewToken =
            await getNewAccessToken(); // 리프레시 토큰으로 엑세스 토큰 재발급
        if (isSuccessNewToken == "NewAccessToken") {
          // 엑세스 토큰을 정상적으로 재발급 받은 경우
          return await getRegisteredStickyData(); // 등록된 포스트잇 요청 함수 재실행
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
      // print("Failed to get data. Error: ${response.statusCode}");
      return "GoToLoginPage";
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
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: Color(0xff717171),
            size: 30,
          ),
        ),
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
                    } else if (!isRegistered) {
                      return const Center(
                        child: Text(
                          '로그인 후 이용할 수 있습니다.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'NanumSquareRoundBold',
                            // fontWeight: FontWeight.w700,
                            // height: 1.31,
                          ),
                        ),
                      );
                    } else if (snapshot.data == "GoToLoginPage") {
                      // print("GoToLoginPage");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                      return const Text("GoToLoginPage");
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
                            // print("index: $index");
                            var postIt = snapshot.data![index];
                            // var id = postIt["stickyId"];
                            var isSold = postIt["isSold"];

                            var nickname = postIt["stickyData"]["nickname"];
                            var hobbies = postIt["stickyData"]["hobbies"];
                            var mbti = postIt["stickyData"]["mbti"];
                            var introduce = postIt["stickyData"]["introduce"];
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
                                    introduce: introduce,
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
                                                    "${hobbies.length >= 1 ? hobbies[0] : 'x'}",
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
                                                    "$introduce",
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

// Future<List> getRegisteredPostItData() async {
//   String response =
//       await rootBundle.loadString('json/test_registered_post_it_json.json');
//   final jsonData = json.decode(response);

//   return jsonData["data"]["stickyData"];
// }
