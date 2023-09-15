import 'package:flutter/material.dart';
import 'package:ssu_meet/tag_data/ideal_tag.dart';

StatefulBuilder myModal(BuildContext context, List idealList) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  if (screenWidth >= 540) {
    //태블릿 사이즈 레이아웃 설정
    screenWidth *= 0.8;
  }
  return StatefulBuilder(
    builder: (context, StateSetter setModalState) => Container(
      color: Colors.transparent,
      width: screenWidth,
      height: screenHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: screenWidth,
            height: screenWidth * 0.4,
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    "assets/images/images2/box1.png",
                    width: screenWidth * 0.5,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.39,
                  top: screenWidth * 0.14,
                  child: Image(
                    width: screenWidth * 0.03,
                    height: screenWidth * 0.03,
                    image:
                        const AssetImage("assets/images/images2/sparkle.png"),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.3,
                  top: screenWidth * 0.12,
                  child: Text(
                    "원하는 이상형을 골라보세요!",
                    style: TextStyle(
                      fontFamily: "Nanum_Ogbice",
                      height: 2,
                      fontSize: screenWidth * 0.045,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.7,
            width: screenWidth * 0.9,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                topLeft: Radius.circular(50),
              ),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: screenWidth * 0.05,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.5,
                  height: screenWidth * 0.08,
                  child: Stack(
                    children: [
                      Positioned(
                        left: screenWidth * 0.08,
                        child: Image.asset(
                          "assets/images/images2/short_tape.png",
                          width: screenWidth * 0.2,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.14,
                        top: screenWidth * -0.02,
                        child: Text(
                          "외모",
                          style: TextStyle(
                              fontSize: screenWidth * 0.07,
                              fontFamily: "Nanum_Ogbice"),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    //카테고리별 차지하는 영역
                    margin: EdgeInsets.only(bottom: screenWidth * 0.05),
                    height: screenHeight * 0.08,
                    width: screenWidth * 0.7,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          for (var i = 0; i < face_to_animal.length; i++)
                            Material(
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: screenWidth * 0.2,
                                    height: screenHeight * 0.03,
                                    margin:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        color: idealList
                                                .contains(face_to_animal[i])
                                            ? Colors.black
                                            : Colors.white),
                                    child: Center(
                                      child: Text(
                                        face_to_animal[i],
                                        style: TextStyle(
                                            fontFamily: "Nanum_Ogbice",
                                            fontSize: screenWidth * 0.03,
                                            color: idealList
                                                    .contains(face_to_animal[i])
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    idealList.contains(
                                            face_to_animal[i]) //리스트에 포함 시킴
                                        ? idealList.remove(face_to_animal[i])
                                        : idealList.add(face_to_animal[i]);
                                    setModalState(() {});
                                  }),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.5,
                  height: screenWidth * 0.08,
                  child: Stack(
                    children: [
                      Positioned(
                        left: screenWidth * 0.08,
                        child: Image.asset(
                          "assets/images/images2/short_tape.png",
                          width: screenWidth * 0.2,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.14,
                        top: screenWidth * -0.02,
                        child: Text(
                          "성격",
                          style: TextStyle(
                            fontSize: screenWidth * 0.07,
                            fontFamily: "Nanum_Ogbice",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    //카테고리별 차지하는 영역
                    margin: EdgeInsets.only(bottom: screenWidth * 0.05),
                    height: screenHeight * 0.08,
                    width: screenWidth * 0.7,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          for (var i = 0; i < personality.length; i++)
                            Material(
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: screenWidth * 0.2,
                                    height: screenHeight * 0.03,
                                    margin:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.black),
                                        color:
                                            idealList.contains(personality[i])
                                                ? Colors.black
                                                : Colors.white),
                                    child: Center(
                                      child: Text(
                                        personality[i],
                                        style: TextStyle(
                                          fontFamily: "Nanum_Ogbice",
                                          fontSize: screenWidth * 0.03,
                                          color:
                                              idealList.contains(personality[i])
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    idealList.contains(
                                            personality[i]) //리스트에 포함 시킴
                                        ? idealList.remove(personality[i])
                                        : idealList.add(personality[i]);
                                    setModalState(() {});
                                  }),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.5,
                  height: screenWidth * 0.08,
                  child: Stack(
                    children: [
                      Positioned(
                        left: screenWidth * 0.05,
                        child: Image.asset(
                          "assets/images/images2/long_tape.png",
                          width: screenWidth * 0.32,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.11,
                        top: screenWidth * -0.016,
                        child: Text(
                          "연애 타입",
                          style: TextStyle(
                            fontSize: screenWidth * 0.07,
                            fontFamily: "Nanum_Ogbice",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    //카테고리별 차지하는 영역
                    margin: EdgeInsets.only(bottom: screenWidth * 0.05),
                    height: screenHeight * 0.08,
                    width: screenWidth * 0.7,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          for (var i = 0; i < style.length; i++)
                            Material(
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: screenWidth * 0.2,
                                    height: screenHeight * 0.03,
                                    margin:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      color: idealList.contains(style[i])
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    child: Center(
                                      child: Text(
                                        style[i],
                                        style: TextStyle(
                                          fontFamily: "Nanum_Ogbice",
                                          fontSize: screenWidth * 0.03,
                                          color: idealList.contains(style[i])
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    idealList.contains(style[i]) //리스트에 포함 시킴
                                        ? idealList.remove(style[i])
                                        : idealList.add(style[i]);
                                    setModalState(() {});
                                  }),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.7,
                    child: const Divider(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      thickness: 1.0,
                    ),
                  ),
                ),
                Center(
                  //선택된 리스트 보여주기
                  child: SizedBox(
                    height: screenWidth * 0.1,
                    width: screenWidth * 0.7,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        children: [
                          for (var i = 0; i < idealList.length; i++)
                            Material(
                              child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: screenWidth * 0.2,
                                    height: screenHeight * 0.03,
                                    margin:
                                        const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      color: Colors.black,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${idealList[i]}  x",
                                        style: TextStyle(
                                          fontFamily: "Nanum_Ogbice",
                                          fontSize: screenWidth * 0.03,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    idealList.remove(idealList[i]);
                                    setModalState(() {});
                                  }),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(
                        screenWidth * 0.27,
                        screenWidth * 0.08,
                      ),
                      side: const BorderSide(color: Colors.black, width: 0.5),
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      shadowColor: const Color.fromRGBO(0, 0, 0, 1),
                      elevation: 5,
                    ),
                    child: Text(
                      "선택 완료",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.03,
                        fontFamily: "Nanum_Ogbice",
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
