import 'package:flutter/material.dart';

class MainPostItDialog extends StatefulWidget {
  final String nickname;
  final int age;
  final String major;
  final String mbti;
  final int height;
  final List hobbies;
  final String introduce;
  final String? instaId;
  final String? kakaoId;
  final String? phoneNumber;
  final List ideals;

  const MainPostItDialog({
    required this.nickname,
    required this.age,
    required this.major,
    required this.mbti,
    required this.height,
    required this.hobbies,
    required this.introduce,
    required this.instaId,
    required this.kakaoId,
    required this.phoneNumber,
    required this.ideals,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPostItDialog();
}

class _MainPostItDialog extends State<MainPostItDialog> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      backgroundColor:
          Colors.transparent, // Set the background color to transparent
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage(
                      "assets/images/images2/yellowpostit2.png",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: screenWidth * 0.2,
                left: screenWidth * 0.15,
                child: SizedBox(
                  height: screenHeight * 0.4,
                  width: screenWidth * 0.5,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "닉네임: ${widget.nickname}",
                          style: const TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "나이: ${widget.age}살",
                          style: const TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "학과: ${widget.major}",
                          style: const TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "MBTI: ${widget.mbti}",
                          style: const TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "키: ${widget.height}cm",
                          style: const TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "취미 1: ${widget.hobbies[0]}",
                          style: const TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "취미 2: ${widget.hobbies[1]}",
                          style: const TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "취미 3: ${widget.hobbies[2]}",
                          style: const TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "자기소개: ${widget.introduce}",
                          style: const TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "이상형: ${widget.ideals}",
                          style: const TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showBuyDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    screenWidth * 0.3,
                    screenWidth * 0.1,
                  ),
                  side: const BorderSide(color: Colors.black, width: 0.5),
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
                ),
                child: Text(
                  "구매하기",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04,
                    fontFamily: "Nanum_Ogbice",
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    screenWidth * 0.3,
                    screenWidth * 0.1,
                  ),
                  side: const BorderSide(color: Colors.black, width: 0.5),
                  backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                  shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
                ),
                child: Text(
                  "닫기",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.04,
                    fontFamily: "Nanum_Ogbice",
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showBuyDialog(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      barrierColor: Colors.white.withOpacity(0.7),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
          actionsPadding: const EdgeInsets.only(bottom: 30),
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1.5,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Color(0xFF020202),
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          shadowColor: const Color(0x3F000000),
          content: const Text(
            '구매를 진행하시면 코인 1개가 차감됩니다. \n구매하시겠습니까? \n',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'NanumSquareRoundBold',
              // fontWeight: FontWeight.w700,
              // height: 1.31,
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 70,
                    height: 25,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                    ),
                    child: const Center(
                      child: Text(
                        "구매하기",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'NanumSquareRoundR',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 70,
                    height: 25,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: const Center(
                      child: Text(
                        "취소",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF010101),
                          fontSize: 10,
                          fontFamily: 'NanumSquareRoundR',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
