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
                onPressed: () {
                  Navigator.pop(context);
                },
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
}
