import 'package:flutter/material.dart';

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
                  Container(
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
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.7,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 100,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                  childAspectRatio: 1 / 1, //item 의 가로 1, 세로 1 의 비율
                  mainAxisSpacing: 10, //수평 Padding
                  crossAxisSpacing: 10, //수직 Padding
                ),
                itemBuilder: (BuildContext context, int index) {
                  // return Text(index.toString());
                  return Center(
                    child: SizedBox(
                      height: screenWidth * 0.4,
                      width: screenWidth * 0.4,
                      child: const Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          // First image

                          Image(
                              image: AssetImage(
                                  "assets/images/images2/yellowpostit.png"),
                              width: 250,
                              height: 250),

                          // Second image overlapped on top of the first image
                          Positioned(
                            left: 60,
                            top: 0,
                            child: Image(
                              image: AssetImage(
                                  "assets/images/images2/tape10.png"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
