import 'package:flutter/material.dart';
import 'package:ssu_meet/dialogs/remove_purchased_post_it_dialog.dart';

class PurchasedPostItDialog extends StatefulWidget {
  final int stickyId;
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

  const PurchasedPostItDialog({
    required this.stickyId,
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
  State<StatefulWidget> createState() => _PurchasedPostItDialog();
}

class _PurchasedPostItDialog extends State<PurchasedPostItDialog> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      backgroundColor: Colors.transparent,
      // Set the background color to transparent
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
                  width: screenWidth * 0.55,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "닉네임: ${widget.nickname}",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "나이: ${widget.age}살",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "학과: ${widget.major}",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "MBTI: ${widget.mbti}",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "키: ${widget.height}cm",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "취미 1: ${widget.hobbies[0]}",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        Text(
                          "취미 2: ${widget.hobbies[1]}",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        Text(
                          "취미 3: ${widget.hobbies[2]}",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "자기소개: ${widget.introduce}",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        widget.instaId == null
                            ? Text(
                                "인스타: x",
                                style: TextStyle(
                                  fontFamily: "Nanum_Ogbice",
                                  fontSize: screenWidth * 0.04,
                                ),
                              )
                            : Text(
                                "인스타: ${widget.instaId}",
                                style: TextStyle(
                                  fontFamily: "Nanum_Ogbice",
                                  fontSize: screenWidth * 0.04,
                                ),
                              ),
                        widget.kakaoId == null
                            ? Text(
                                "카카오톡: x",
                                style: TextStyle(
                                  fontFamily: "Nanum_Ogbice",
                                  fontSize: screenWidth * 0.04,
                                ),
                              )
                            : Text(
                                "카카오톡: ${widget.kakaoId}",
                                style: TextStyle(
                                  fontFamily: "Nanum_Ogbice",
                                  fontSize: screenWidth * 0.04,
                                ),
                              ),
                        widget.phoneNumber == null
                            ? Text(
                                "연락처: x",
                                style: TextStyle(
                                  fontFamily: "Nanum_Ogbice",
                                  fontSize: screenWidth * 0.04,
                                ),
                              )
                            : Text(
                                "연락처: ${widget.phoneNumber}",
                                style: TextStyle(
                                  fontFamily: "Nanum_Ogbice",
                                  fontSize: screenWidth * 0.04,
                                ),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "이상형:",
                              style: TextStyle(
                                fontFamily: "Nanum_Ogbice",
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.43,
                              height: screenWidth * 0.1,
                              child: SingleChildScrollView(
                                child: Wrap(
                                  children: widget.ideals.map((item) {
                                    return Container(
                                      width: screenWidth * 0.12,
                                      height: screenWidth * 0.04,
                                      margin: EdgeInsets.fromLTRB(
                                        screenWidth * 0.01,
                                        screenWidth * 0.01,
                                        screenWidth * 0.01,
                                        0,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: screenWidth * 0.001,
                                        ),
                                        color: Colors.transparent,
                                      ),
                                      child: Center(
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            fontFamily: "Nanum_Ogbice",
                                            fontSize: screenWidth * 0.025,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
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
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    screenWidth * 0.2,
                    screenWidth * 0.1,
                  ),
                  side: const BorderSide(color: Colors.black, width: 0.5),
                  backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                  shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
                ),
                child: Text(
                  "삭제",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.04,
                    fontFamily: "Nanum_Ogbice",
                  ),
                ),
                onPressed: () {
                  removePurchasedPostIt(context, widget.stickyId);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    screenWidth * 0.2,
                    screenWidth * 0.1,
                  ),
                  side: const BorderSide(color: Colors.black, width: 0.5),
                  backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
                  shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
                ),
                child: Text(
                  "닫기",
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
            ],
          ),
        ],
      ),
    );
  }
}
