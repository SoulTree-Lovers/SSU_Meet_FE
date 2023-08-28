import 'package:flutter/material.dart';

class RegisteredDialog extends StatefulWidget {
  final String nickname;
  final List hobbies;
  final String mbti;
  final String introduction;
  final List ideals;

  const RegisteredDialog({
    required this.nickname,
    required this.hobbies,
    required this.mbti,
    required this.introduction,
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
                    )),
              ),
              Positioned(
                top: screenWidth * 0.2,
                left: screenWidth * 0.15,
                child: SizedBox(
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.4,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "닉네임: ${widget.nickname}",
                          style: TextStyle(
                              fontFamily: "Nanum_Ogbice",
                              fontSize: screenWidth * 0.04,
                              color: Colors.black),
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
                                  color: Colors.black),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.hobbies[0]}".toString(),
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: "Nanum_Ogbice",
                                      fontSize: screenWidth * 0.04,
                                      color: Colors.black),
                                ),
                                Text(
                                  "${widget.hobbies[1]}".toString(),
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: "Nanum_Ogbice",
                                      fontSize: screenWidth * 0.04,
                                      color: Colors.black),
                                ),
                                Text(
                                  "${widget.hobbies[2]}".toString(),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "이상형:  ",
                              style: TextStyle(
                                fontFamily: "Nanum_Ogbice",
                                fontSize: screenWidth * 0.04,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.28,
                              height: screenWidth * 0.1,
                              child: SingleChildScrollView(
                                child: Wrap(
                                  spacing: 4,
                                  //alignment: WrapAlignment.start,
                                  children: widget.ideals.map(
                                    (item) {
                                      return Container(
                                        width: screenWidth * 0.11,
                                        height: screenWidth * 0.04,
                                        margin:
                                            const EdgeInsets.only(bottom: 5),
                                        padding: const EdgeInsets.only(top: 2),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.black, width: 0.5),
                                        ),
                                        child: Text(
                                          item,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "Nanum_Ogbice",
                                            fontSize: screenWidth * 0.025,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
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
                                    widget.introduction.toString(),
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
                                  "이상형: ",
                                  style: TextStyle(
                                      fontFamily: "Nanum_Ogbice",
                                      fontSize: screenWidth * 0.04,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    spacing: 5,
                                    alignment: WrapAlignment.start,
                                    children: [
                                      // Chip(
                                      //   backgroundColor: Colors.transparent,

                                      //   side: BorderSide(
                                      //     color: Colors.black,
                                      //     width: 0.5
                                      //   ),
                                      //   label: Text("${widget.ideals[0]}".toString(),
                                      //     textAlign: TextAlign.center,
                                      //     style: TextStyle(
                                      //     fontFamily: "Nanum_Ogbice",
                                      //     fontSize: screenWidth * 0.03,
                                      //     color: Colors.black
                                      //   ),),),
                                      Container(
                                        padding: const EdgeInsets.only(top: 2),
                                        width: screenWidth * 0.14,
                                        height: screenWidth * 0.05,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.black, width: 0.5),
                                        ),
                                        child: Text(
                                          "${widget.ideals[0]}".toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "Nanum_Ogbice",
                                            fontSize: screenWidth * 0.03,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 2),
                                        width: screenWidth * 0.14,
                                        height: screenWidth * 0.05,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Text(
                                          "${widget.ideals[1]}".toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "Nanum_Ogbice",
                                              fontSize: screenWidth * 0.03,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 2),
                                        width: screenWidth * 0.14,
                                        height: screenWidth * 0.05,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Text(
                                          "${widget.ideals[2]}".toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "Nanum_Ogbice",
                                            fontSize: screenWidth * 0.03,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shadowColor: Colors.black26,
                    side: const BorderSide(color: Colors.black, width: 0.5),
                    fixedSize: Size(screenWidth * 0.15, screenWidth * 0.06)),
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
        ],
      ),
    );
  }
}
