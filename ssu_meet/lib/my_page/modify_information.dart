import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ssu_meet/dept_data/temp_majors.dart';
import '../profile_data/profile.dart';



class ModifyPage extends StatefulWidget {
  final MyData? initData;

  const ModifyPage({super.key, this.initData});

  @override
  State<ModifyPage> createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  List<String> genderList = ["선택하기", '남', '여'];
  List<DropdownMenuItem<Item>> collegeList = List.empty(growable: true);
  List<DropdownMenuItem<Item>> majorList = List.empty(growable: true);
  final formKey = GlobalKey<FormState>();
  Item? tmpCollege;
  Item? tmpMajor;
  var data;

  Item? searchInItemList(String name, List<DropdownMenuItem<Item>> list) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].value!.title == name) return list[i].value;
    }
  }

  @override
  void initState() {
    super.initState();
    data = widget.initData!;
    collegeList = Colleges().colleges;
    tmpCollege = searchInItemList(data.college, collegeList);
    majorList = Majors(tmpCollege!.ind).majors;
    tmpMajor = searchInItemList(data.major, majorList);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
        shadowColor: const Color.fromRGBO(158, 156, 156, 1),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left,
                color: Color(0xff717171), size: 30)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: screenWidth,
                height: screenWidth * 2,
                decoration: const BoxDecoration(
                  //배경이미지
                  image: DecorationImage(
                      image: AssetImage("assets/images/images2/paper.png"),
                      fit: BoxFit.fill),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.08),
                      ),
                      Text(
                        "기본 정보를 등록해주세요!",
                        style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.1),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.02),
                      ),
                      Text(
                        "*구매할 경우 보이는 정보입니다.",
                        style: TextStyle(
                            fontFamily: "Nanum_Ogbice",
                            fontSize: screenWidth * 0.05),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image(
                              image: const AssetImage(
                                  "assets/images/images2/yellowpostit.png"),
                              width: screenWidth * 0.85,
                              height: screenWidth * 0.85),
                          Positioned(
                            left: screenWidth * 0.31,
                            top: screenWidth * -0.05,
                            child: SizedBox(
                              width: screenWidth * 0.25,
                              height: screenWidth * 0.25,
                              child: const Image(
                                image: AssetImage(
                                    "assets/images/images2/tape10.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            //텍스트 위치 조정
                            top: screenWidth * 0.11,
                            left: screenWidth * 0.15,
                            child: SizedBox(
                              width: screenWidth * 0.8,
                              height: screenWidth * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: SizedBox(
                                      width: screenWidth * 0.8,
                                      height: screenWidth * 0.08,
                                      child: Row(
                                        children: [
                                          Text(
                                            "성별:  ",
                                            style: TextStyle(
                                                fontFamily: "Nanum_Ogbice",
                                                fontSize: screenWidth * 0.05),
                                          ),
                                          DropdownButton<String>(
                                            value: data.sex,
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            iconSize: screenWidth * 0.04,
                                            style:
                                                DropdownTextStyle(screenWidth),
                                            alignment: Alignment.center,
                                            underline: Container(
                                              height: screenWidth * 0.0015,
                                              //밑줄두께
                                              color: Colors.black,
                                            ),
                                            items: genderList
                                                .map<DropdownMenuItem<String>>(
                                              (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (String? newVal) {
                                              setState(
                                                () {
                                                  data.sex = newVal!;
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                      width: screenWidth * 0.8,
                                      height: screenWidth * 0.08,
                                      child: Row(
                                        children: [
                                          Text(
                                            "학과: ",
                                            style: TextStyle(
                                                fontFamily: "Nanum_Ogbice",
                                                fontSize: screenWidth * 0.048),
                                          ),
                                          DropdownButton<Item>(
                                            value: tmpCollege,
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            iconSize: screenWidth * 0.04,
                                            underline: Container(
                                                height: screenHeight * 0.001,
                                                color: Colors.black),
                                            style:
                                                DropdownTextStyle(screenWidth),
                                            items: collegeList,
                                            onChanged: (Item? newVal) {
                                              setState(
                                                () {
                                                  tmpCollege = newVal;
                                                  data.college = newVal!.title;
                                                  majorList =
                                                      Majors(newVal.ind).majors;
                                                  tmpMajor = majorList[0].value;
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                      width: screenWidth * 0.8,
                                      height: screenWidth * 0.08,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: screenWidth * 0.095),
                                          ),
                                          DropdownButton<Item>(
                                            value: tmpMajor,
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            iconSize: screenWidth * 0.04,
                                            underline: Container(
                                                height: screenHeight * 0.001,
                                                color: Colors.black),
                                            style:
                                                DropdownTextStyle(screenWidth),
                                            items: majorList,
                                            onChanged: (newVal) {
                                              setState(
                                                () {
                                                  tmpMajor =
                                                      majorList[newVal!.ind]
                                                          .value;
                                                  data.major = newVal.title;
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                      width: screenWidth * 0.8,
                                      height: screenWidth * 0.1,
                                      child: Row(
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Text(
                                            "생년월일: ",
                                            style: TextStyle(
                                                fontFamily: "Nanum_Ogbice",
                                                fontSize: screenWidth * 0.05),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: screenWidth * 0.02),
                                          ),
                                          SizedBox(
                                            width: screenWidth * 0.16,
                                            height: screenWidth * 0.1,
                                            //입력칸 너비,높이 조절
                                            child: MyFormField(
                                              key: const ValueKey(1),
                                              initText: data.birth,
                                              hintText: "MMYYDD",
                                              screenWidth: screenWidth,
                                              validator: (val) {
                                                if (val == '' || val!.isEmpty) {
                                                  return "필수입력";
                                                }
                                                return null;
                                              },
                                              onSaved: (val) {
                                                setState(() {
                                                  data.birth = val;
                                                });
                                              },
                                            ),
                                          ),

                                          Text(
                                            "  키: ",
                                            style: TextStyle(
                                              fontFamily: "Nanum_Ogbice",
                                              fontSize: screenWidth * 0.05,
                                            ),
                                          ),
                                          // Padding(padding: EdgeInsets.only(left:screenWidth*0.056)),
                                          SizedBox(
                                            width: screenWidth * 0.09,
                                            height: screenWidth * 0.1,
                                            //입력 칸 너비,높이 조절
                                            child: MyFormField(
                                              key: const ValueKey(2),
                                              initText: data.height.toString(),
                                              hintText: "입력",
                                              screenWidth: screenWidth,
                                              validator: (val) {
                                                if (val == '' || val!.isEmpty) {
                                                  return "필수입력";
                                                }
                                                return null;
                                              },
                                              onSaved: (val) {
                                                setState(
                                                  () {
                                                    data.height =
                                                        int.parse(val);
                                                  },
                                                );
                                              },
                                            ),
                                          ),

                                          Text(
                                            "cm",
                                            style: TextStyle(
                                              fontFamily: "Nanum_Ogbice",
                                              fontSize: screenWidth * 0.035,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                      width: screenWidth * 0.5,
                                      height: screenWidth * 0.07,
                                      child: Row(
                                        children: [
                                          Text(
                                            "SNS: ",
                                            style: TextStyle(
                                              fontFamily: "Nanum_Ogbice",
                                              fontSize: screenWidth * 0.05,
                                            ),
                                          ),
                                          Flexible(
                                            child: MyFormField(
                                              key: const ValueKey(3),
                                              initText: data.instaId,
                                              hintText: "1.인스타",
                                              screenWidth: screenWidth,
                                              onSaved: (val) {
                                                setState(
                                                  () {
                                                    data.instaId = val;
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                      width: screenWidth * 0.5,
                                      height: screenWidth * 0.07,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          left: screenWidth * 0.09,
                                        ),
                                        child: MyFormField(
                                          key: const ValueKey(4),
                                          initText: data.kakaoId,
                                          hintText: "2.카카오",
                                          screenWidth: screenWidth,
                                          onSaved: (val) {
                                            setState(
                                              () {
                                                data.kakaoId = val;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                      width: screenWidth * 0.5,
                                      height: screenWidth * 0.07,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          left: screenWidth * 0.09,
                                        ),
                                        child: MyFormField(
                                          key: const ValueKey(5),
                                          initText: data.phoneNumber,
                                          hintText: "3.전화번호",
                                          screenWidth: screenWidth,
                                          onSaved: (val) {
                                            setState(
                                              () {
                                                data.phoneNumber = val;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: screenWidth * 0.015),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "*SNS는 셋 중 하나 이상 필수로 입력해주세요.",
                                      style: TextStyle(
                                          fontSize: 0.02 * screenWidth,
                                          color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: screenWidth * 0.07,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          fixedSize: const Size(95, 36),
                          side:
                              const BorderSide(color: Colors.black, width: 0.5),
                          backgroundColor:
                              const Color.fromRGBO(255, 255, 255, 1),
                          shadowColor: const Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                        child: Text(
                          "수정 완료",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.043,
                              fontFamily: "Nanum_Ogbice"),
                        ),
                        onPressed: () {
                          formKey.currentState!.save(); // 일단 저장
                          if (formKey.currentState!.validate() &&
                              data.sex != genderList[0] &&
                              data.college != collegeList[0].value &&
                              data.major != majorList[0].value) {
                            if ((data.instaId != '' ||
                                data.kakaoId != '' ||
                                data.phoneNumber != '')) {
                              data.age = AgeCalculation(data.birth);
                              print("필수 입력 요건이 충족됨");
                              // 변경된 값 보내기
                              print(json.encode(data.toJson()));
                              Navigator.pop(context);
                            } else
                              print("sns를 입력하지 않음");
                          } else {
                            print("필수 입력 조건이 충족되지 않음"); //필수 입력 값을 다시 초기화
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyFormField extends StatefulWidget {
  final String hintText;
  final FormFieldValidator? validator;
  final FormFieldSetter? onSaved;
  final double screenWidth;
  final String initText;

  const MyFormField({
    Key? key,
    required this.hintText,
    required this.screenWidth,
    required this.initText,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  State<MyFormField> createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      cursorWidth: 1.5,
      cursorHeight: widget.screenWidth * 0.03,
      cursorColor: Colors.black,
      style: TextStyle(
        fontSize: widget.screenWidth * 0.05,
        fontFamily: "Nanum_Ogbice",
        color: Colors.black,
      ),
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: widget.screenWidth * 0.02),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: widget.screenWidth * 0.04,
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black, width: widget.screenWidth * 0.0015),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black, width: widget.screenWidth * 0.0015),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: widget.screenWidth * 0.0015,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: widget.screenWidth * 0.0015,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: widget.screenWidth * 0.0015,
          ),
        ),
      ),
      validator: widget.validator,
      onSaved: widget.onSaved,
      initialValue: widget.initText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}

TextStyle DropdownTextStyle(double screenWidth) {
  return TextStyle(
    fontFamily: "Nanum_Ogbice",
    fontSize: screenWidth * 0.04,
    color: Colors.black,
  );
}

int AgeCalculation(String val) {
  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;
  int currentDay = DateTime.now().day;
  int _age;

  if (val.length != 6) print("error:생년월일 6자리를 입력하세요");

  int birthYear = int.parse(val.substring(0, 2));
  int birthMonth = int.parse(val.substring(2, 4));
  int birthDay = int.parse(val.substring(4, 6));

  if (birthYear >= 0 && birthYear <= 23) {
    _age = currentYear - (2000 + birthYear);
  } else {
    _age = currentYear - (1900 + birthYear);
  }
  if (birthMonth > currentMonth ||
      (birthMonth == currentMonth && birthDay > currentDay)) {
    _age--; //아직 생일이 안 지난 경우, 한 살 더 빼줌
  }
  return _age;
}
