import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestMainPage extends StatefulWidget {
  const TestMainPage({super.key});

  @override
  State<TestMainPage> createState() => _TestMainPageState();
}

class _TestMainPageState extends State<TestMainPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("등록하기 버튼 클릭 !");
                    },
                    child: Container(
                      width: 90,
                      height: 40,
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color(0xFF010101)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "+ 등록하기",
                          style: TextStyle(
                            fontFamily: "Ongeul",
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            FutureBuilder(
              future: getPostItFrontData(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the future is not yet completed
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // If an error occurred
                  return Text('Error: ${snapshot.error}');
                } else {
                  // If the future completed successfully
                  return SizedBox(
                    height: screenHeight * 0.7,
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                        childAspectRatio: 1 / 1, //item 의 가로 1, 세로 1 의 비율
                        mainAxisSpacing: 10, //수평 Padding
                        crossAxisSpacing: 10, //수직 Padding
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        var postIt = snapshot.data![index];
                        var nickname = postIt["nickname"];
                        var age = postIt["age"];
                        var mbti = postIt["mbti"];
                        var hobby = postIt["hobby"];
                        // return Text(index.toString());
                        // Future<String> nickname = getPostItFrontNickname(index);
                        // var age = getPostItFrontData(index)["age"];
                        // var mbti = getPostItFrontData(index)["mbti"];
                        // var hobby = getPostItFrontData(index)["hobby"];
                        return GestureDetector(
                          onTap: () {
                            print("Tapped Post It $index");
                          },
                          child: Center(
                            child: Container(
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  // First image

                                  const Image(
                                      image: AssetImage(
                                          "assets/images/images2/yellowpostit.png"),
                                      width: 250,
                                      height: 250),

                                  // Second image overlapped on top of the first image
                                  const Positioned(
                                    left: 80,
                                    top: 0,
                                    child: Image(
                                      image: AssetImage(
                                          "assets/images/images2/tape10.png"),
                                    ),
                                  ),
                                  Positioned(
                                    top: 60,
                                    left: 70,
                                    child: SizedBox(
                                      height: 120,
                                      width: 120,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "닉네임: $nickname",
                                              style: const TextStyle(
                                                fontFamily: "Nanum_Ogbice",
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "나이: $age",
                                              style: const TextStyle(
                                                fontFamily: "Nanum_Ogbice",
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "MBTI: $mbti",
                                              style: const TextStyle(
                                                fontFamily: "Nanum_Ogbice",
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "취미: $hobby",
                                              style: const TextStyle(
                                                fontFamily: "Nanum_Ogbice",
                                                fontSize: 20,
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
                }
              },
            ),
          ],
        ),
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
