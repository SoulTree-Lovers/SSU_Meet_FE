import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ssu_meet/dialogs/main_post_it_dialog.dart';
import 'package:ssu_meet/pages/login_page.dart';
import 'package:ssu_meet/widgets/document_duplicate_image.dart';
import 'package:ssu_meet/widgets/registration_button_black.dart';
import 'package:ssu_meet/widgets/vertical_line_image.dart';

import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollButton = false;

  var futureData; // 데이터 패치 함수 레퍼런스 변수

  // 서버에서 데이터 패치
  List<dynamic> data = [];

  int page = 0; // 초기 페이지 0
  bool isLoading = false; // 현재 로딩 중인지 여부
  bool hasMoreData = true; // 서버에 추가 데이터가 있는 지 여부
  int allStickyCount = 0; // 전체 이성이 등록한 포스트잇 개수
  int myStickyCount = 0; // 내가 등록한 포스트잇 개수

  bool isRegistered = false;

  @override
  void initState() {
    super.initState();
    futureData = fetchData(context);

    _scrollController.addListener(() {
      if (_scrollController.offset >= 200) {
        setState(() {
          _showScrollButton = true;
        });
      } else {
        setState(() {
          _showScrollButton = false;
        });
      }
    });
  }

  Future<dynamic> fetchData(BuildContext context) async {
    print("Fetching data");
    // 만약 이미 패치중이거나 더이상 데이터가 없다면 즉시 리턴
    if (isLoading || !hasMoreData) {
      return [];
    }

    // 현재 데이터 패치 중이므로 true
    setState(() {
      isLoading = true;
    });

    // 디바이스에 저장된 access token과 refresh token 읽어오기 (존재하지 않으면 null 리턴)
    final accessToken = await storage.read(key: 'access_token');
    // final refreshToken = await storage.read(key: 'refresh_token');

    // var url = 'http://localhost:8080/v1/members/main?page=$page&size=1000'; // 로컬 테스트용
    var url =
        'https://ssumeet.shop/v1/members/main?page=$page&size=1000'; // 배포된 서버

    final http.Response response;

    if (accessToken == null) {
      isRegistered = false;
      // 로그인한 적 없는 사용자 (엑세스 토큰을 전달하지 않음 - 모든 성별 포스트잇 공개)
      response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': '*',
        },
      );

      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      final stickyData = responseData["data"]["stickyData"];

      // print("responseData: $responseData");

      if (response.statusCode == 200) {
        // 엑세스 토큰이 유효한 경우 (정상적으로 이성 포스트잇 받음)

        // 페이지가 0인 경우 포스트잇 개수 초기화 (현재 버전에서는 페이지가 무조건 0임)
        if (page == 0) {
          allStickyCount = responseData["data"]["allStickyCount"] ?? 0;
          myStickyCount = 0; // 서버에서 전달해주지 않음 (로그인을 안 했으니 0개로 설정)
          // print("allStickyCount: $allStickyCount");
          // print("myStickyCount: $myStickyCount");
        }
        if (stickyData.isEmpty) {
          setState(() {
            hasMoreData = false;
          });
        } else {
          setState(() {
            data.addAll(stickyData);
            page++; // 페이지 += 1
          });
        }
        setState(() {
          isLoading = false;
        });

        return data;
      } else {
        return [];
      }
    } else {
      isRegistered = true;
      // 이미 로그인한 기록이 있는 사용자 (엑세스 토큰 전달 - 이성 포스트잇만 공개)
      response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Access-Control-Allow-Origin': '*',
        },
      );

      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      final stickyData = responseData["data"]["stickyData"];
      final message = responseData["message"];

      if (response.statusCode == 200) {
        // 엑세스 토큰이 유효한 경우 (정상적으로 이성 포스트잇 받음)

        // 페이지가 0인 경우 포스트잇 개수 초기화 (현재 버전에서는 페이지가 무조건 0임)
        if (page == 0) {
          allStickyCount = responseData["data"]["allStickyCount"] ?? 0;
          myStickyCount = responseData["data"]["myStickyCount"] ?? 0;
        }
        if (stickyData.isEmpty) {
          setState(() {
            hasMoreData = false;
          });
        } else {
          setState(() {
            data.addAll(stickyData);
            page++; // 페이지 += 1
          });
        }
        setState(() {
          isLoading = false;
        });

        return data;
      } else if (response.statusCode == 401) {
        // 엑세스 토큰이 만료되었거나, 유효하지 않은 경우
        if (message == "Token has expired") {
          // 엑세스 토큰이 만료된 경우
          final isSuccessNewToken =
              await getNewAccessToken(); // 리프레시 토큰으로 엑세스 토큰 재발급
          if (isSuccessNewToken == "NewAccessToken") {
            // 엑세스 토큰을 정상적으로 재발급 받은 경우
            setState(() {
              isLoading = false;
            });
            return await fetchData(context); // 데이터 요청 함수 재실행
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
        // 그 외 status 에러
        // print("Error: ${response.statusCode}");
        return "GoToLoginPage";
      }
    }
  }

  // 스크롤 최상단으로 가기
  void _scrollToTop() async {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    _refresh();
  }

  // 포스트잇 데이터 새로고침
  void _refresh() async {
    setState(() {
      page = 0;
      data = [];
      isLoading = false;
      hasMoreData = true;
      fetchData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/paper_background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.all(screenHeight * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      !isRegistered
                          ? ElevatedButton(
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.only(left: 0, right: 0),
                                backgroundColor: Colors.white,
                                shadowColor: Colors.black26,
                                side: const BorderSide(
                                  color: Colors.black,
                                ),
                                fixedSize: Size(
                                    screenWidth * 0.25, screenHeight * 0.005),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "<  로그인 하기",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "NanumSquareRoundBold",
                                    fontSize: screenWidth * 0.025,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(
                              width: screenWidth * 0.25,
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          DocumentDuplicateImage(screenWidth),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            "나의 포스트잇: $myStickyCount 개",
                            style: TextStyle(
                              fontFamily: "NanumSquareRoundR",
                              fontSize: screenWidth * 0.03,
                            ),
                          ),
                          VerticalLineImage(),
                          DocumentDuplicateImage(screenWidth),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            !isRegistered
                                ? "모든 포스트잇: $allStickyCount 개"
                                : "모든 이성 포스트잇: $allStickyCount 개",
                            style: TextStyle(
                              fontFamily: "NanumSquareRoundR",
                              fontSize: screenWidth * 0.03,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 서버 연동 시 사용할 포스트잇 데이터 패치 GridView
                SizedBox(
                  height: screenHeight * 0.73,
                  child: FutureBuilder(
                    future: futureData,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "네트워크 에러 발생 !!",
                              style: TextStyle(
                                fontFamily: "Nanum_Ogbice",
                                fontSize: screenWidth * 0.07,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "(새로고침 후 다시 시도해보세요)",
                              style: TextStyle(
                                fontFamily: "Nanum_Ogbice",
                                fontSize: screenWidth * 0.05,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        );
                      } else if (!snapshot.hasData) {
                        return Text(
                          "Data is null",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.1,
                            color: Colors.black,
                          ),
                        );
                      } else if (snapshot.data == "GoToLoginPage") {
                        print("GoToLoginPage");
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                        return const Text("GoToLoginPage");
                      } else {
                        // data.addAll(snapshot.data!);

                        return GridView.builder(
                          controller: _scrollController,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns in the grid
                            childAspectRatio: 1 / 1, //item 의 가로 1, 세로 1 의 비율
                            mainAxisSpacing: 10, //수평 Padding
                            crossAxisSpacing: 10,
                          ),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var postIt = snapshot.data![index];
                            var stickyId = postIt["stickyId"];
                            var age = postIt["stickyData"]["age"];
                            var major = postIt["stickyData"]["major"];
                            var height = postIt["stickyData"]["height"];
                            var instaId = postIt["stickyData"]["instaId"];
                            var kakaoId = postIt["stickyData"]["kakaoId"];
                            var phoneNumber =
                                postIt["stickyData"]["phoneNumber"];
                            var nickname = postIt["stickyData"]["nickname"];
                            var mbti = postIt["stickyData"]["mbti"];
                            var hobbies = postIt["stickyData"]["hobbies"];
                            var ideals = postIt["stickyData"]["ideals"];
                            var introduce = postIt["stickyData"]["introduce"];

                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => MainPostItDialog(
                                    stickyId: stickyId,
                                    nickname: nickname,
                                    age: age,
                                    major: major,
                                    mbti: mbti,
                                    height: height,
                                    hobbies: hobbies,
                                    introduce: introduce,
                                    instaId: instaId,
                                    kakaoId: kakaoId,
                                    phoneNumber: phoneNumber,
                                    ideals: ideals,
                                  ),
                                );
                                print("Tapped Post It (id: $stickyId)");
                              },
                              child: Center(
                                child: SizedBox(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      // First image
                                      Image(
                                        image: const AssetImage(
                                            "assets/images/images2/yellowpostit.png"),
                                        width: screenWidth * 0.4,
                                        height: screenWidth * 0.4,
                                      ),
                                      // Second image overlapped on top of the first image
                                      Positioned(
                                        left: screenWidth * 0.1,
                                        top: screenWidth * -0.07,
                                        child: Image(
                                          width: screenWidth * 0.2,
                                          height: screenWidth * 0.2,
                                          image: const AssetImage(
                                            "assets/images/images2/tape10.png",
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: screenWidth * 0.1,
                                        left: screenWidth * 0.1,
                                        child: SizedBox(
                                          height: screenWidth * 0.2,
                                          width: screenWidth * 0.2,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "닉네임: $nickname",
                                                  style: TextStyle(
                                                    fontFamily: "Nanum_Ogbice",
                                                    fontSize:
                                                        screenWidth * 0.04,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  "나이: $age",
                                                  style: TextStyle(
                                                    fontFamily: "Nanum_Ogbice",
                                                    fontSize:
                                                        screenWidth * 0.04,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  "MBTI: $mbti",
                                                  style: TextStyle(
                                                    fontFamily: "Nanum_Ogbice",
                                                    fontSize:
                                                        screenWidth * 0.04,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  "취미 1: ${hobbies.length >= 1 ? hobbies[0] : 'x'}",
                                                  style: TextStyle(
                                                    fontFamily: "Nanum_Ogbice",
                                                    fontSize:
                                                        screenWidth * 0.04,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  "취미 2: ${hobbies.length >= 2 ? hobbies[1] : 'x'}",
                                                  style: TextStyle(
                                                    fontFamily: "Nanum_Ogbice",
                                                    fontSize:
                                                        screenWidth * 0.04,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  "취미 3: ${hobbies.length >= 3 ? hobbies[2] : 'x'}",
                                                  style: TextStyle(
                                                    fontFamily: "Nanum_Ogbice",
                                                    fontSize:
                                                        screenWidth * 0.04,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          // RegistrationButtonWhite(screenHeight, screenWidth),
          RegistrationButtonBlack(
            screenHeight,
            screenWidth,
            context,
          ),
        ],
      ),
      floatingActionButton: _showScrollButton
          ? FloatingActionButton(
              backgroundColor: Colors.transparent, // 배경을 투명하게 설정
              elevation: 0, // 그림자 없애기
              onPressed: _scrollToTop,
              child: Container(
                width: screenWidth * 0.1,
                height: screenWidth * 0.1,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/top_button.png"),
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
