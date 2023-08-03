import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssu_meet/dept_data/temp_majors.dart';
import 'dart:convert';
import 'package:ssu_meet/profile_data/profile.dart';
import 'package:ssu_meet/functions/age_calculation.dart';
import 'package:ssu_meet/widgets/dropdown_text_style.dart';
import 'package:ssu_meet/widgets/custom_textformfield.dart';

String? sex; //성별
Item? college; //단과대
Item? major; //전공
String? birth; //생년월일
int? height; //키
int? age; //나이
String? instaId;
String? kakaoId;
String? phoneNumber;

class InputProfile extends StatefulWidget {
  const InputProfile({super.key});

  @override
  State<StatefulWidget> createState() => _InputProfile();
}

class _InputProfile extends State<InputProfile> {
  List<String> genderList = ["선택하기", '남', '여'];
  List<DropdownMenuItem<Item>> collegeList = List.empty(growable: true);
  List<DropdownMenuItem<Item>> majorList = List.empty(growable: true);

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    sex = genderList[0];
    collegeList = Colleges().colleges;
    college = collegeList[0].value;
    majorList = Majors(0).majors;
    major = majorList[0].value;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom:
              BorderSide(color: Colors.black12, width: screenWidth * 0.003),
            ),
          ),
        ),
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
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.01),
                      ),
                      Text(
                        "*성별, 생년월일은 추후 수정 불가합니다.",
                        style: TextStyle(
                            fontSize: 0.025 * screenWidth,
                            color: Colors.red),
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
                                            value: sex,
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
                                                  sex = newVal!;
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
                                            value: college,
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
                                                  college = newVal;
                                                  majorList =
                                                      Majors(newVal!.ind)
                                                          .majors;
                                                  major = majorList[0].value;
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
                                            value: major,
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
                                                  major = newVal;
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
                                              hintText: "MMYYDD",
                                              screenWidth: screenWidth,
                                              validator: (val) {
                                                if (val == '' || val==null) {
                                                  return "필수입력";
                                                }
                                                return null;
                                              },
                                              onSaved: (val) {
                                                setState(() {
                                                  birth = val;
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
                                              hintText: "입력",
                                              screenWidth: screenWidth,
                                              validator: (val) {
                                                if (val == '' || val==null) {
                                                  return "필수입력";
                                                }
                                                return null;
                                              },
                                              onSaved: (val) {
                                                setState(
                                                      () {
                                                    height = int.parse(val);
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
                                              hintText: "1.인스타",
                                              screenWidth: screenWidth,
                                              onSaved: (val) {
                                                setState(
                                                      () {
                                                    instaId = val;
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
                                          hintText: "2.카카오",
                                          screenWidth: screenWidth,
                                          onSaved: (val) {
                                            setState(
                                                  () {
                                                kakaoId = val;
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
                                          hintText: "3.전화번호",
                                          screenWidth: screenWidth,
                                          onSaved: (val) {
                                            setState(
                                                  () {
                                                phoneNumber = val;
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
                          fixedSize: Size(screenWidth * 0.2, screenWidth * 0.06),
                          side:
                          const BorderSide(color: Colors.black, width: 0.5),
                          backgroundColor:
                          const Color.fromRGBO(255, 255, 255, 1),
                          shadowColor: const Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                        child: Center(
                          child:Text(
                          "작성 완료",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.038,
                              fontFamily: "Nanum_Ogbice"),
                        ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save(); //생년월일, 키 제대로 입력 시 저장.
                            if(sex != genderList[0] && //나머지 조건들 한 번 더 체크
                              college != collegeList[0].value &&
                              major != majorList[0].value &&
                              instaId != '' ||
                              kakaoId != '' ||
                              phoneNumber != '') {
                              age = AgeCalculation(birth!);
                              print("필수 입력 요건이 충족됨");
                              printData();
                            }
                            else print("필수 입력 조건이 충족되지 않음");
                          } else  {
                            print("필수 입력 조건이 충족되지 않음");
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


void printData() {
  print("함수가 실행은 됐습니다.");
  final data = MyData(
      sex:sex!,
      birth:birth!,
      age:age!,
      college:college!.title,
      major:major!.title,
      height:height!,
      instaId:instaId,
      kakaoId:kakaoId,
      phoneNumber:phoneNumber);
  print(json.encode(data.toJson()));
}