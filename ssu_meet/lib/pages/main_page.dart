import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssu_meet/dialogs/main_post_it_dialog.dart';
import 'package:ssu_meet/widgets/document_duplicate_image.dart';
import 'package:ssu_meet/widgets/registration_button_black.dart';
import 'package:ssu_meet/widgets/vertical_line_image.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollButton = false;

  @override
  void initState() {
    super.initState();

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

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    int myPostIt = getMyPostIt();
    int totalPostIt = getTotalPostIt();

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/paper_background.png"),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DocumentDuplicateImage(screenWidth),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        "나의 포스트잇: $myPostIt 개",
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
                        "현재 등록된 포스트잇: $totalPostIt 장",
                        style: TextStyle(
                          fontFamily: "NanumSquareRoundR",
                          fontSize: screenWidth * 0.03,
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: getPostItFrontData(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    // if (snapshot.connectionState == ConnectionState.waiting) {
                    //   // While the future is not yet completed
                    //   return const CircularProgressIndicator();
                    // } else if (snapshot.hasError) {
                    //   // If an error occurred
                    //   return Text('Error: ${snapshot.error}');
                    if (snapshot.hasData) {
                      // If the future completed successfully
                      return SizedBox(
                        height: screenHeight * 0.75,
                        child: GridView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                            childAspectRatio: 1 / 1, //item 의 가로 1, 세로 1 의 비율
                            mainAxisSpacing: 10, //수평 Padding
                            crossAxisSpacing: 10,
                            //수직 Padding
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            var postIt = snapshot.data![index];
                            var id = postIt["stickyId"];
                            var sex = postIt["stickyData"]["sex"];
                            var birthDate = postIt["stickyData"]["birthDate"];
                            var age = postIt["stickyData"]["age"];
                            var college = postIt["stickyData"]["college"];
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
                                  builder: (BuildContext context) {
                                    return MainPostItDialog(
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
                                    );
                                  },
                                );
                                print("Tapped Post It (id: $id)");
                                print("Tapped Post It (age: $age)");
                                print("Tapped Post It (instaId: $instaId)");
                              },
                              child: Center(
                                child: Container(
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
                                              "assets/images/images2/tape10.png"),
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
                                                  "취미 1: ${hobbies[0]}",
                                                  style: TextStyle(
                                                    fontFamily: "Nanum_Ogbice",
                                                    fontSize:
                                                        screenWidth * 0.04,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  "취미 2: ${hobbies[1]}",
                                                  style: TextStyle(
                                                    fontFamily: "Nanum_Ogbice",
                                                    fontSize:
                                                        screenWidth * 0.04,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  "취미 3: ${hobbies[2]}",
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
                        ),
                      );
                    } else {
                      return const Text("데이터가 없습니다.");
                    }
                  },
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

// Future<List> getPostItFrontData() async {
//   // 서버에서 포스트잇 앞면 데이터 가져오기 (임시)
//   String jsonString = await rootBundle.loadString('json/post_it_json.json');
//   final jsonResponse = json.decode(jsonString);

//   return jsonResponse;
// }

Future<List> getPostItFrontData() async {
  // 서버에서 포스트잇 앞면 데이터 가져오기 (임시)
  String jsonString =
      await rootBundle.loadString('json/test_main_post_it_data.json');
  final jsonResponse = json.decode(jsonString);
  // print(jsonResponse["data"]["stickyData"]);
  return jsonResponse["data"]["stickyData"];
}

// 내가 등록한 포스트잇 개수 가져오기 (임시)
int getMyPostIt() {
  return 3;
}

// 전체 사용자가 등록한 포스트잇 개수 가져오기 (임시)
int getTotalPostIt() {
  return 50;
}
