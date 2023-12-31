import 'package:flutter/material.dart';

class RegisteredDialog extends StatefulWidget {
  final String nickname;
  final List hobbies;
  final String mbti;
  final String introduce;
  final List ideals;

  const RegisteredDialog({
    required this.nickname,
    required this.hobbies,
    required this.mbti,
    required this.introduce,
    required this.ideals,
    Key? key,
  }) : super(key: key);

  @override
  State<RegisteredDialog> createState() => _RegisteredDialogState();
}

class _RegisteredDialogState extends State<RegisteredDialog> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return AlertDialog(
      backgroundColor: Colors.transparent,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
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
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.4,
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
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "취미: ",
                              style: TextStyle(
                                fontFamily: "Nanum_Ogbice",
                                fontSize: screenWidth * 0.04,
                                color: Colors.black,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.hobbies.isNotEmpty ? widget.hobbies[0] : 'x'}",
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: "Nanum_Ogbice",
                                      fontSize: screenWidth * 0.04,
                                      color: Colors.black),
                                ),
                                Text(
                                  "${widget.hobbies.length >= 2 ? widget.hobbies[1] : 'x'}",
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: "Nanum_Ogbice",
                                      fontSize: screenWidth * 0.04,
                                      color: Colors.black),
                                ),
                                Text(
                                  "${widget.hobbies.length >= 3 ? widget.hobbies[2] : 'x'}",
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontFamily: "Nanum_Ogbice",
                                    fontSize: screenWidth * 0.04,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "MBTI: ${widget.mbti}",
                          style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.04,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "자기소개: ",
                              style: TextStyle(
                                fontFamily: "Nanum_Ogbice",
                                fontSize: screenWidth * 0.04,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.introduce,
                                textAlign: TextAlign.left,
                                softWrap: true,
                                style: TextStyle(
                                  fontFamily: "Nanum_Ogbice",
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "이상형:  ",
                              style: TextStyle(
                                  fontFamily: "Nanum_Ogbice",
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.black),
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
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shadowColor: Colors.black26,
              side: const BorderSide(color: Colors.black, width: 0.5),
              fixedSize: Size(
                screenWidth * 0.3,
                screenWidth * 0.1,
              ),
            ),
            child: Text(
              "확인",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Nanum_Ogbice",
                fontSize: screenWidth * 0.03,
                //fontWeight: FontWeight.w500
              ),
            ),
          ),
        ],
      ),
    );
  }
}
