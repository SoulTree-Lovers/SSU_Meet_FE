import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssu_meet/widgets/document_duplicate_image.dart';
import 'package:ssu_meet/widgets/main_page_post_it.dart';
import 'package:ssu_meet/widgets/registration_button_black.dart';
import 'package:ssu_meet/widgets/vertical_line_image.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
          SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/paper_background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       GestureDetector(
                  //         onTap: () {
                  //           print("등록하기 버튼 클릭 !");
                  //         },
                  //         child: Container(
                  //           width: 90,
                  //           height: 40,
                  //           decoration: ShapeDecoration(
                  //             color: Colors.white.withOpacity(0.5),
                  //             shape: RoundedRectangleBorder(
                  //               side: const BorderSide(
                  //                   width: 1, color: Color(0xFF010101)),
                  //               borderRadius: BorderRadius.circular(20),
                  //             ),
                  //           ),
                  //           child: const Center(
                  //             child: Text(
                  //               "+ 등록하기",
                  //               style: TextStyle(
                  //                 fontFamily: "Ongeul",
                  //                 fontSize: 20,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
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
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // While the future is not yet completed
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        // If an error occurred
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // If the future completed successfully
                        return MainPagePostIt(
                          screenHeight,
                          snapshot,
                          screenWidth,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          // RegistrationButtonWhite(screenHeight, screenWidth),
          RegistrationButtonBlack(screenHeight, screenWidth, context),
        ],
      ),
    );
  }
}

Future<List> getPostItFrontData() async {
  // 서버에서 포스트잇 앞면 데이터 가져오기
  String jsonString = await rootBundle.loadString('json/post_it_json.json');
  final jsonResponse = json.decode(jsonString);

  return jsonResponse;
}

// 내가 등록한 포스트잇 개수 가져오기 (임시)
int getMyPostIt() {
  return 3;
}

// 전체 사용자가 등록한 포스트잇 개수 가져오기 (임시)
int getTotalPostIt() {
  return 50;
}
