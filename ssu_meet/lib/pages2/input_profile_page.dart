import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssu_meet/dept_data/temp_majors.dart';
import 'dart:convert';

String? gender; //성별
Item? college; //단과대
Item? major; //전공
String? birth; //생년월일
int? height; //키
int? age; //나이
String? instaId;
String? kakaoId;
String? phoneNum;

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
    gender = genderList[0];
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
                                            value: gender,
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
                                                  gender = newVal!;
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
                                                if (val == '' || val!.isEmpty) {
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
                                                if (val == '' || val!.isEmpty) {
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
                                                phoneNum = val;
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
                          "작성 완료",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.043,
                              fontFamily: "Nanum_Ogbice"),
                        ),
                        onPressed: () {
                          formKey.currentState!.save();
                          if (formKey.currentState!.validate() &&
                              gender != genderList[0] &&
                              college != collegeList[0].value &&
                              major != majorList[0].value &&
                              instaId != '' ||
                              kakaoId != '' ||
                              phoneNum != '') {
                            age = AgeCalculation(birth!);
                            print("필수 입력 요건이 충족됨");
                            printData();
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

class MyFormField extends StatelessWidget {
  final String hintText;
  final FormFieldValidator? validator;
  final FormFieldSetter? onSaved;
  final double screenWidth;

  const MyFormField({
    Key? key,
    required this.hintText,
    required this.screenWidth,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      cursorWidth: 1.5,
      cursorHeight: screenWidth * 0.03,
      cursorColor: Colors.black,
      style: TextStyle(
        fontSize: screenWidth * 0.05,
        fontFamily: "Nanum_Ogbice",
        color: Colors.black,
      ),
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: screenWidth * 0.02),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: screenWidth * 0.04,
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Colors.black, width: screenWidth * 0.0015),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Colors.black, width: screenWidth * 0.0015),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: screenWidth * 0.0015,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: screenWidth * 0.0015,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: screenWidth * 0.0015,
          ),
        ),
      ),
      validator: validator,
      onSaved: onSaved,
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
  int _currentYear = DateTime.now().year;
  int _currentMonth = DateTime.now().month;
  int _currentDay = DateTime.now().day;
  int _age;

  if(val.length!=6) print("error:생년월일 6자리를 입력하세요");

  int _birthYear = int.parse(val.substring(0, 2));
  int _birthMonth = int.parse(val.substring(2, 4));
  int _birthDay = int.parse(val.substring(4, 6));

  if (_birthYear >= 0 && _birthYear <= 23) {
    _age = _currentYear - (2000 + _birthYear);
  } else {
    _age = _currentYear - (1900 + _birthYear);
  }
  if (_birthMonth > _currentMonth ||
      (_birthMonth == _currentMonth && _birthDay > _currentDay)) {
    _age--; //아직 생일이 안 지난 경우, 한 살 더 빼줌
  }
  return _age;
}

class MyData {
  final String sex; //성별
  final String birth; //생년월일
  final int age; //나이
  final String college; //단과대
  final String major; //전공
  final int height; //키
  final String? instaId; //인스타
  final String? kakaoId; //카카오
  final String? phoneNum; //전화번호

  MyData(
    this.sex,
    this.birth,
    this.age,
    this.college,
    this.major,
    this.height,
    this.instaId,
    this.kakaoId,
    this.phoneNum,
  );

  Map<String, dynamic> toJson() => {
        "sex": (sex == "남") ? "MALE" : "FEMALE",
        "birth": birth,
        "age": age,
        "college": college,
        "major": major,
        "height": height,
        "instaID": (instaId != '') ? instaId : null, // SNS는 3개 중 1개 이상 입력
        "kakaoId": (kakaoId != '') ? kakaoId : null,
        "phoneNumber": (phoneNum != '') ? phoneNum : null,
      };
}

void printData() {
  print("함수가 실행은 됐습니다.");
  final data = MyData(gender!, birth!, age!, college!.title, major!.title,
      height!, instaId, kakaoId, phoneNum);
  print(json.encode(data.toJson()));
}
