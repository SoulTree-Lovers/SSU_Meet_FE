import 'package:flutter/material.dart';

SizedBox MainPagePostIt(double screenHeight,
    AsyncSnapshot<List<dynamic>> snapshot, double screenWidth) {
  ScrollController scrollController = ScrollController();

  return SizedBox(
    height: screenHeight * 0.7,
    child: GridView.builder(
      shrinkWrap: true,
      itemCount: snapshot.data!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      image:
                          const AssetImage("assets/images/images2/tape10.png"),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "닉네임: $nickname",
                              style: TextStyle(
                                fontFamily: "Nanum_Ogbice",
                                fontSize: screenWidth * 0.04,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "나이: $age",
                              style: TextStyle(
                                fontFamily: "Nanum_Ogbice",
                                fontSize: screenWidth * 0.04,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "MBTI: $mbti",
                              style: TextStyle(
                                fontFamily: "Nanum_Ogbice",
                                fontSize: screenWidth * 0.04,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "취미: $hobby",
                              style: TextStyle(
                                fontFamily: "Nanum_Ogbice",
                                fontSize: screenWidth * 0.04,
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
}

// 서버에 데이터 추가 요청
Future<void> _fetchMoreData() async {
  // Make an API request to fetch the next batch of data from the server
  // Append the new data to your existing data list
  // Update the state of your widget with the new data
}
