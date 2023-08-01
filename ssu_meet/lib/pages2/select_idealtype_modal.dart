import 'package:flutter/material.dart';
import 'package:ssu_meet/tag_data/ideal_tag.dart';

class SelectIdealType extends StatefulWidget {
  SelectIdealType({Key? key}) : super(key: key);

  @override
  State<SelectIdealType> createState() => _SelectIdealTypeState();
}

class _SelectIdealTypeState extends State<SelectIdealType> {
  List ideal_list = [];

  @override
  void initState() {
    super.initState();
    ideal_list = [];
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.transparent,
      height: screenHeight,
      child: Stack(
        children: [
          Positioned(
            left: screenWidth * 0.22,
            top: screenWidth * 0.15,
            child: SizedBox(
              width: screenWidth * 0.55,
              height: screenWidth * 0.25,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/images2/box1.png",
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                      left: screenWidth * 0.15,
                      top: screenWidth * 0.068,
                      child: Image(
                          width: screenWidth * 0.03,
                          height: screenWidth * 0.03,
                          image: const AssetImage(
                              "assets/images/images2/sparkle.png"))),
                  Positioned(
                      left: screenWidth * 0.05,
                      top: screenWidth * 0.04,
                      child: Text("원하는 이상형을 골라보세요!",
                          style: TextStyle(
                              fontFamily: "Nanum_Ogbice",
                              height: 2,
                              fontSize: screenWidth * 0.05))),
                ],
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.3,
            child: Container(
              height: screenHeight * 0.7,
              width: screenWidth * 0.84,
              margin: EdgeInsets.fromLTRB(
                  screenWidth * 0.08, 0, screenWidth * 0.08, 0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: screenWidth * 0.05)),
                  SizedBox(
                    width: screenWidth * 0.5,
                    height: screenWidth * 0.08,
                    child: Stack(
                      children: [
                        Positioned(
                          left: screenWidth * 0.08,
                          child: Image.asset(
                            "assets/images/images2/short_tape.png",
                          ),
                        ),
                        Positioned(
                          left: screenWidth * 0.15,
                          top: screenWidth * -0.018,
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border:
                                              Border.all(color: Colors.black),
                                          color: ideal_list
                                                  .contains(face_to_animal[i])
                                              ? Colors.black
                                              : Colors.white),
                                      child: Center(
                                        child: Text(
                                          "${face_to_animal[i]}",
                                          style: TextStyle(
                                              fontFamily: "Nanum_Ogbice",
                                              fontSize: screenWidth * 0.03,
                                              color: ideal_list.contains(
                                                      face_to_animal[i])
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      ideal_list.contains(
                                              face_to_animal[i]) //리스트에 포함 시킴
                                          ? ideal_list.remove(face_to_animal[i])
                                          : ideal_list.add(face_to_animal[i]);
                                      setState(() {});
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
                          ),
                        ),
                        Positioned(
                          left: screenWidth * 0.15,
                          top: screenWidth * -0.018,
                          child: Text(
                            "성격",
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border:
                                              Border.all(color: Colors.black),
                                          color: ideal_list
                                                  .contains(personality[i])
                                              ? Colors.black
                                              : Colors.white),
                                      child: Center(
                                        child: Text(
                                          "${personality[i]}",
                                          style: TextStyle(
                                              fontFamily: "Nanum_Ogbice",
                                              fontSize: screenWidth * 0.03,
                                              color: ideal_list
                                                      .contains(personality[i])
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      ideal_list.contains(
                                              personality[i]) //리스트에 포함 시킴
                                          ? ideal_list.remove(personality[i])
                                          : ideal_list.add(personality[i]);
                                      setState(() {});
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
                          left: screenWidth * 0.03,
                          child: Image.asset(
                            "assets/images/images2/short_tape.png",
                            width: screenWidth * 0.3,
                            height: screenWidth * 0.06,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                          left: screenWidth * 0.1,
                          bottom: screenWidth * 0.02,
                          child: Text(
                            "연애 타입",
                            style: TextStyle(
                                fontSize: screenWidth * 0.06,
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border:
                                              Border.all(color: Colors.black),
                                          color: ideal_list.contains(style[i])
                                              ? Colors.black
                                              : Colors.white),
                                      child: Center(
                                        child: Text(
                                          "${style[i]}",
                                          style: TextStyle(
                                              fontFamily: "Nanum_Ogbice",
                                              fontSize: screenWidth * 0.03,
                                              color:
                                                  ideal_list.contains(style[i])
                                                      ? Colors.white
                                                      : Colors.black),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      ideal_list.contains(style[i]) //리스트에 포함 시킴
                                          ? ideal_list.remove(style[i])
                                          : ideal_list.add(style[i]);
                                      setState(() {});
                                    }),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                        width: screenWidth * 0.7,
                        child: const Divider(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            thickness: 1.0)),
                  ),
                  Center(
                    //선택된 리스트 보여주기
                    child: SizedBox(
                      height: screenHeight * 0.1,
                      width: screenWidth * 0.7,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          children: [
                            for (var i = 0; i < ideal_list.length; i++)
                              Material(
                                  child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        width: screenWidth * 0.2,
                                        height: screenHeight * 0.03,
                                        margin: const EdgeInsets.fromLTRB(
                                            5, 5, 5, 0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border:
                                                Border.all(color: Colors.black),
                                            color: Colors.black),
                                        child: Center(
                                          child: Text(
                                            "${ideal_list[i]}  x",
                                            style: TextStyle(
                                                fontFamily: "Nanum_Ogbice",
                                                fontSize: screenWidth * 0.03,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        ideal_list.remove(ideal_list[i]);
                                        setState(() {});
                                      })),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(screenWidth * 0.19, screenWidth * 0.06),
                          side:
                              const BorderSide(color: Colors.black, width: 0.5),
                          backgroundColor:
                              const Color.fromRGBO(255, 255, 255, 1),
                          shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                        "선택 완료",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.035,
                            fontFamily: "Nanum_Ogbice"),
                      ),
                      onPressed: () {
                        Navigator.pop(context, ideal_list);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
