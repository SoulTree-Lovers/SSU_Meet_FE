import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ssu_meet/pages/login_page.dart';
import 'package:ssu_meet/widgets/select_idealtype_modal.dart';
import 'package:ssu_meet/widgets/custom_textformfield_with_limit_letters.dart';
import 'package:ssu_meet/dialogs/status_of_registration_dialog.dart';
import 'package:ssu_meet/dialogs/alert_required_input.dialog.dart';

class MyStickyData {
  final String nickname;
  final String mbti;
  final List hobbies;
  final List ideals;
  final String introduce;

  MyStickyData(
    this.nickname,
    this.mbti,
    this.hobbies,
    this.ideals,
    this.introduce,
  );

  Map<String, dynamic> toJson() => {
        "nickname": nickname,
        "mbti": mbti,
        "hobbies": hobbies,
        "ideals": ideals,
        "introduce": introduce,
      };
}

class InputPostIt extends StatefulWidget {
  const InputPostIt({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InputPostIt();
}

class _InputPostIt extends State<InputPostIt> {
  final formKey = GlobalKey<FormState>();
  String? nickname;
  String? mbti;
  String? introduce;
  List hobbies = ['', '', '']; //취미 리스트
  List ideals = [];

  int flag = 0;

  List<String> mbtiList = [
    'ENFP',
    'ENFJ',
    'ENTP',
    'ENTJ',
    'ESFP',
    'ESFJ',
    'ESTP',
    'ESTJ',
    'INFP',
    'INFJ',
    'INTP',
    'INTJ',
    'ISFP',
    'ISFJ',
    'ISTP',
    'ISTJ'
  ];

  // api 연동- 포스트잇 등록 POST 요청
  Future<int> sendStickyData() async {
    int isExceed;
    final myStickyData = MyStickyData(
      nickname!,
      mbti!,
      hobbies,
      ideals,
      introduce!,
    );

    var token = await storage.read(key: "token");

    print("input post it dialog token: $token");

    print(json.encode(myStickyData.toJson()));

    const url = 'http://localhost:8080/v1/sticky/new';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(myStickyData.toJson()),
    );

    print(
        "-------------------------------- 데이터 전송 --------------------------------");

    // 한글 깨짐 현상 해결: utf8.decode(response.bodyBytes)를 사용하여 입력받기
    final responseData = jsonDecode(utf8.decode(response.bodyBytes));

    // print("responseData: ${responseData["status"]}");

    if (responseData["status"] == "SUCCESS") {
      isExceed = 0;
    } else if (responseData["status"] == "ERROR") {
      isExceed = 1;
    } else {
      print('Failed to send data. Error: ${response.statusCode}');
      isExceed = 2;
    }
    print("responseData['message']: ${responseData["message"]}");
    return isExceed;
  }

  // Future<int> sendStickyData() async {
  //   int isExceed;
  //   Map<String, dynamic> toJson() => {
  //         "nickname": nickname,
  //         "mbti": mbti,
  //         "hobbies": hobby,
  //         "ideals": idealList,
  //         "introduce": introduce,
  //       };
  //   print(json.encode(toJson()));
  //   var token = await storage.read(key: "token");

  //   print("input post it dialog token: $token");

  //   var body = json.encode(toJson());
  //   const url = 'http://localhost:8080/v1/sticky/new';
  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //     // body: json.encode(toJson()),
  //     body: body,
  //   );
  //   final responseData = json.decode(response.body);
  //   if (responseData["status"] == "SUCCESS" &&
  //       responseData["message"] == "포스트잇 등록 성공") {
  //     isExceed = 0;
  //   }
  //   if (responseData["status"] == "ERROR" &&
  //       responseData["message"] == "포스트잇 최대 등록 개수 초과") {
  //     isExceed = 1;
  //   } else {
  //     print('Failed to send data. Error: ${response.statusCode}');
  //     isExceed = 2;
  //   }
  //   print(responseData["message"]);
  //   return isExceed;
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if (screenWidth >= 540) {
      //태블릿 사이즈 레이아웃 설정
      screenWidth *= 0.8;
    }
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Container(
        width: screenWidth,
        height: screenWidth * 1.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage(
              "assets/images/images2/paper.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.05,
                  ),
                ),
                Text('자신을 소개할 내용을 등록해주세요!',
                    style: TextStyle(
                        fontFamily: "Nanum_Ogbice",
                        fontSize: screenWidth * 0.06),
                    textAlign: TextAlign.center),
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.02,
                  ),
                ),
                Text(
                  '*추후 수정이 불가하니 신중히 입력 바랍니다.',
                  style: TextStyle(
                    fontFamily: "Nanum_Ogbice",
                    fontSize: screenWidth * 0.04,
                  ),
                  textAlign: TextAlign.center,
                ),
                Stack(
                  children: [
                    Image(
                      image: const AssetImage(
                        "assets/images/images2/yellowpostit2.png",
                      ),
                      width: screenWidth * 0.7,
                      height: screenWidth,
                      fit: BoxFit.cover,
                    ),
                    //텍스트
                    Positioned(
                      top: screenWidth * 0.15,
                      left: screenWidth * 0.08,
                      child: SizedBox(
                        width: screenWidth * 0.6,
                        height: screenWidth * 0.8,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "닉네임:   ",
                                    style: TextStyle(
                                      fontFamily: "Nanum_Ogbice",
                                      fontSize: screenWidth * 0.045,
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.4,
                                    height: screenWidth * 0.1,
                                    child: MyFormField(
                                      key: const ValueKey(1),
                                      hintText: "10자 이내",
                                      screenWidth: screenWidth,
                                      maxLength: 10,
                                      maxLine: 1,
                                      validator: (val) {
                                        if (val == '' || val == null) {
                                          return "필수입력";
                                        }
                                        return null;
                                      },
                                      onSaved: (val) {
                                        setState(() {
                                          nickname = val;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "MBTI:   ",
                                    style: TextStyle(
                                      fontFamily: "Nanum_Ogbice",
                                      fontSize: screenWidth * 0.045,
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.2,
                                    height: screenWidth * 0.08,
                                    child: DropdownButton(
                                      alignment: Alignment.center,
                                      value: mbti,
                                      underline: Container(
                                        height: screenWidth * 0.0015,
                                        color: Colors.black,
                                      ),
                                      style: TextStyle(
                                        fontFamily: "Nanum_Ogbice",
                                        fontSize: screenWidth * 0.045,
                                        color: Colors.black,
                                      ),
                                      hint: Text(
                                        "선택하기",
                                        style: TextStyle(
                                          fontFamily: "Nanum_Ogbice",
                                          fontSize: screenWidth * 0.04,
                                        ),
                                      ),
                                      items: mbtiList
                                          .map<DropdownMenuItem<String>>(
                                        (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (newVal) {
                                        setState(() {
                                          mbti = newVal;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "취미:     ",
                                    style: TextStyle(
                                      fontFamily: "Nanum_Ogbice",
                                      fontSize: screenWidth * 0.045,
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.4,
                                    height: screenWidth * 0.1,
                                    child: MyFormField(
                                      key: const ValueKey(2),
                                      hintText: "1. 15자 이내",
                                      screenWidth: screenWidth,
                                      maxLength: 15,
                                      maxLine: 1,
                                      onSaved: (val) {
                                        setState(() {
                                          hobbies[0] = val;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: screenWidth * 0.45,
                                height: screenWidth * 0.06,
                                padding: EdgeInsets.only(
                                  left: screenWidth * 0.048,
                                ),
                                child: MyFormField(
                                  key: const ValueKey(3),
                                  hintText: "2.",
                                  screenWidth: screenWidth,
                                  maxLength: 15,
                                  maxLine: 1,
                                  onSaved: (val) {
                                    setState(() {
                                      hobbies[1] = val;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                width: screenWidth * 0.45,
                                height: screenWidth * 0.06,
                                padding: EdgeInsets.only(
                                  left: screenWidth * 0.048,
                                ),
                                child: MyFormField(
                                  key: const ValueKey(4),
                                  hintText: "3.",
                                  helperText: "*취미는 하나 이상 필수로 입력해주세요.",
                                  screenWidth: screenWidth,
                                  maxLength: 15,
                                  maxLine: 1,
                                  onSaved: (val) {
                                    setState(() {
                                      hobbies[2] = val;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: screenWidth * 0.01),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "자기소개: ",
                                    style: TextStyle(
                                      fontFamily: "Nanum_Ogbice",
                                      fontSize: screenWidth * 0.045,
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.4,
                                    height: screenWidth * 0.2,
                                    child: MyFormField(
                                      key: const ValueKey(5),
                                      hintText: "200자 이내",
                                      screenWidth: screenWidth,
                                      maxLine: null,
                                      maxLength: 200,
                                      validator: (val) {
                                        if (val == '' || val == null) {
                                          return "필수입력";
                                        }
                                        return null;
                                      },
                                      onSaved: (val) {
                                        setState(() {
                                          introduce = val;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "이상형:  ",
                                    style: TextStyle(
                                      fontFamily: "Nanum_Ogbice",
                                      fontSize: screenWidth * 0.045,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Offstage(
                                        offstage: (flag == 0) ? true : false,
                                        child: SizedBox(
                                          width: screenWidth * 0.45,
                                          height: screenWidth * 0.1,
                                          child: SingleChildScrollView(
                                            child: Wrap(
                                              children: [
                                                for (var i = 0;
                                                    i < ideals.length;
                                                    i++)
                                                  Container(
                                                    width: screenWidth * 0.12,
                                                    height: screenWidth * 0.04,
                                                    margin: EdgeInsets.fromLTRB(
                                                      screenWidth * 0.01,
                                                      screenWidth * 0.01,
                                                      screenWidth * 0.01,
                                                      0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      border: Border.all(
                                                        color: Colors.black,
                                                        width:
                                                            screenWidth * 0.001,
                                                      ),
                                                      color: Colors.transparent,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "${ideals[i]}",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Nanum_Ogbice",
                                                          fontSize:
                                                              screenWidth *
                                                                  0.025,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: screenWidth * 0.01),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.3,
                                        height: screenWidth * 0.05,
                                        child: Stack(
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.black,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                              ),
                                              onPressed: () async {
                                                ideals = [];
                                                await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        myModal(
                                                          context,
                                                          ideals,
                                                        ));
                                                setState(() {
                                                  flag =
                                                      (ideals.isEmpty) ? 0 : 1;
                                                });
                                              },
                                              child: Container(
                                                height: screenWidth * 0.04,
                                                padding: EdgeInsets.only(
                                                  left: screenWidth * 0.03,
                                                ),
                                                child: Text(
                                                  "이상형 선택하기!",
                                                  style: TextStyle(
                                                    fontFamily: "Nanum_Ogbice",
                                                    fontSize:
                                                        screenWidth * 0.028,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: screenWidth * -0.01,
                                              left: screenWidth * -0.007,
                                              width: screenWidth * 0.07,
                                              height: screenWidth * 0.07,
                                              child: const Image(
                                                image: AssetImage(
                                                  "assets/images/images2/whiteheart2.png",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.22,
                      height: screenWidth * 0.08,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.black,
                            width: 0.5,
                          ),
                          backgroundColor:
                              const Color.fromRGBO(255, 255, 255, 1),
                          shadowColor: const Color.fromRGBO(0, 0, 0, 1),
                          elevation: 5,
                        ),
                        child: Text(
                          "작성 완료",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.035,
                            fontFamily: "Nanum_Ogbice",
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            if (mbti != null &&
                                ideals.isNotEmpty &&
                                (hobbies[0] != '' ||
                                    hobbies[1] != '' ||
                                    hobbies[2] != '')) {
                              // 필수 입력 조건 충족 완료(이상형 포함)
                              hobbies.removeWhere(
                                  (element) => element == ''); // 취미에서 공백 요소 제거
                              print(
                                  "닉네임: $nickname\nmbti: $mbti\n자기소개: $introduce\n이상형:");
                              ideals.forEach(print);
                              print("취미:");
                              hobbies.forEach(print);

                              // 등록 개수 초과 여부 알림 팝업창 호출
                              // final result = sendStickyData();
                              // if (result == 0 || result == 1) showStatusOfRegistration(context, result);
                              showStatusOfRegistration(context,
                                  0); // 임시 (0: 등록 가능 , 1; 등록 불가능 , 2: error)
                              sendStickyData();
                            } else {
                              //  print("값이 유효하지 않음");
                              alertRequiredInput(context,screenWidth);
                            }
                          } else {
                            // print("값이 유효하지 않음");
                            alertRequiredInput(context,screenWidth);
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.06),
                    ),
                    SizedBox(
                      width: screenWidth * 0.22,
                      height: screenWidth * 0.08,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.black,
                            width: 0.5,
                          ),
                          backgroundColor:
                              const Color.fromRGBO(255, 255, 255, 1),
                          shadowColor: const Color.fromRGBO(0, 0, 0, 1),
                          elevation: 5,
                        ),
                        child: Text(
                          "작성 취소",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.035,
                            fontFamily: "Nanum_Ogbice",
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
