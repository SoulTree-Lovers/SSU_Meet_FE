import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bottom_picker/bottom_picker.dart';

import 'package:ssu_meet/dept_data/temp_majors.dart';
import 'package:ssu_meet/pages/login_page.dart';
import 'package:ssu_meet/user_profile_data/user_profile.dart';
import 'package:ssu_meet/functions/age_calculation.dart';
import 'package:ssu_meet/widgets/dropdown_text_style.dart';
import 'package:ssu_meet/widgets/custom_textformfield.dart';
import 'package:ssu_meet/dialogs/alert_required_input.dialog.dart';
import 'package:ssu_meet/dialogs/register_completed.dialog.dart';
import 'package:ssu_meet/dialogs/personal_info_processing_policy.dialog.dart';
import 'package:http/http.dart' as http;

import '../widgets/link_text.dart';

class InputProfile extends StatefulWidget {
  const InputProfile({super.key});

  @override
  State<StatefulWidget> createState() => _InputProfile();
}

class _InputProfile extends State<InputProfile> {
  List<String> genderList = ["선택하기", '남', '여'];
  List<DropdownMenuItem<Item>> collegeList = List.empty(growable: true);
  List<DropdownMenuItem<Item>> majorList = List.empty(growable: true);
  // List<String> birthYearList = List.empty(growable: true);
  // List<String> birthMonthList = List.empty(growable: true);
  // List<String> birthDayList = List.empty(growable: true);
  Item? college; //단과대
  Item? major; //전공
  var data;
  bool isDateSelected = false;
  bool isAgree = false;
  final formKey = GlobalKey<FormState>();

  // api 연동 - POST 요청 함수
  Future<dynamic> sendUserProfileData(UserProfile newUser) async {
    final accessToken = await storage.read(key: 'access_token');
    const url = '//ssumeet.shop/v1/members/new';

    // print(json.encode(newUser.toJson()));

    if (accessToken == null) {
      return "GoToLoginPage";
    }

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Access-Control-Allow-Origin': '*',
      },
      body: json.encode(newUser.toJson()),
    );

    final responseData = jsonDecode(utf8.decode(response.bodyBytes));
    final isSuccess = responseData["status"];
    final message = responseData["message"];
    // print(responseData);

    if (response.statusCode == 200) {
      if (isSuccess == "SUCCESS") {
        // 개인 정보 등록 완료
        return "CompletedRegister";
      } else if (message == "NoAccessToken") {
        // 토큰 없음
        return "GoToLoginPage";
      } else if (message == "CantFindUser") {
        // 유저 찾을 수 없음
        return "GoToLoginPage";
      }
    } else if (response.statusCode == 401) {
      // 엑세스 토큰이 만료되었거나, 유효하지 않은 경우
      if (message == "Token has expired") {
        // 엑세스 토큰이 만료된 경우
        final isSuccessNewToken =
            await getNewAccessToken(); // 리프레시 토큰으로 엑세스 토큰 재발급
        if (isSuccessNewToken == "NewAccessToken") {
          // 엑세스 토큰을 정상적으로 재발급 받은 경우 -> 그대로 작업 완료
          return "CompletedRegister";
        } else if (isSuccessNewToken == "storageDelete") {
          // 리프레시 토큰이 만료된 경우
          return "GoToLoginPage";
        } else if (isSuccessNewToken == "tokenError") {
          // 리프레시 토큰이 에러가 발생한 경우
          return "GoToLoginPage";
        } else {
          // 네트워크 에러 또는 토큰 재발급 함수 자체에 에러가 발생한 경우
          return "GoToLoginPage";
        }
      } else {
        // 엑세스 토큰이 유효하지 않은 경우 및 그 외 예외
        await storage.deleteAll(); // 저장되어 있던 토큰 모두 삭제
        return "GoToLoginPage";
      }
    } else {
      // print('Failed to send data. Error: ${response.statusCode}');
      return "GoToLoginPage"; // 네트워크 에러
    }
  }

  // 취미 3개 미만 입력 시
  // ["축구", "", ""] x
  // ["축구"] o -> 이 형식으로

  @override
  void initState() {
    super.initState();
    collegeList = Colleges().colleges;
    college = collegeList[0].value;
    majorList = Majors(0).majors;
    major = majorList[0].value;
    data = UserProfile(
      sex: genderList[0],
      birthDate: '',
      age: 0,
      college: college!.title,
      major: major!.title,
      height: 0,
      instaId: null,
      kakaoId: null,
      phoneNumber: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    List<LinkTextItem> linkTextItems = [
      LinkTextItem(text: '기본 정보 등록 시 '),
      LinkTextItem(
        text: '개인정보 처리방침 및\n서비스 이용약관',
        isLink: true,
        onTap: () {
          showPersonalInfoProcessingPolicy(context, screenWidth);
        },
      ),
      LinkTextItem(text: '에 동의하는 것을 의미합니다.'),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black12,
                width: screenWidth * 0.003,
              ),
            ),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          // 뒤로가기 버튼 동작을 막으려면 true를 반환합니다.
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight,
                decoration: const BoxDecoration(
                  //배경이미지
                  image: DecorationImage(
                    image: AssetImage("assets/images/images2/paper.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.08,
                        ),
                      ),
                      Text(
                        "기본 정보를 등록해주세요!",
                        style: TextStyle(
                          fontFamily: "Nanum_Ogbice",
                          fontSize: screenWidth * 0.1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.02,
                        ),
                      ),
                      Text(
                        "*구매할 경우 보이는 정보입니다.",
                        style: TextStyle(
                          fontFamily: "Nanum_Ogbice",
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.01,
                        ),
                      ),
                      Text(
                        "*성별, 생년월일은 추후 수정 불가합니다.",
                        style: TextStyle(
                          fontFamily: "NanumSquareAc",
                          fontSize: 0.03 * screenWidth,
                          color: const Color.fromRGBO(255, 0, 0, 1),
                        ),
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.95,
                            height: screenWidth * 0.95,
                            child: const Image(
                              image: AssetImage(
                                  "assets/images/images2/yellowpostit.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            left: screenWidth * 0.33,
                            top: screenWidth * -0.08,
                            child: Image(
                              image: const AssetImage(
                                "assets/images/images2/tape10.png",
                              ),
                              width: screenWidth * 0.3,
                              height: screenWidth * 0.32,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            //텍스트 위치 조정
                            top: screenWidth * 0.14,
                            left: screenWidth * 0.22,
                            child: SizedBox(
                              width: screenWidth * 0.8,
                              height: screenWidth * 0.8,
                              child: Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: screenWidth * 0.8,
                                      height: screenWidth * 0.09,
                                      child: Row(
                                        children: [
                                          Text(
                                            "성별:  ",
                                            style: TextStyle(
                                              fontFamily: "Nanum_Ogbice",
                                              fontSize: screenWidth * 0.05,
                                            ),
                                          ),
                                          DropdownButton<String>(
                                            value: data.sex,
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                            ),
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
                                    SizedBox(
                                      width: screenWidth * 0.8,
                                      height: screenWidth * 0.09,
                                      child: Row(
                                        children: [
                                          Text(
                                            "학과: ",
                                            style: TextStyle(
                                              fontFamily: "Nanum_Ogbice",
                                              fontSize: screenWidth * 0.048,
                                            ),
                                          ),
                                          DropdownButton<Item>(
                                            value: college,
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                            ),
                                            iconSize: screenWidth * 0.04,
                                            underline: Container(
                                              height: screenHeight * 0.001,
                                              color: Colors.black,
                                            ),
                                            style:
                                                DropdownTextStyle(screenWidth),
                                            items: collegeList,
                                            onChanged: (Item? newVal) {
                                              setState(
                                                () {
                                                  college = newVal;
                                                  data.college = newVal!.title;
                                                  majorList =
                                                      Majors(newVal.ind).majors;
                                                  major = majorList[0].value;
                                                  data.major = major!.title;
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.8,
                                      height: screenWidth * 0.09,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: screenWidth * 0.095,
                                            ),
                                          ),
                                          DropdownButton<Item>(
                                            value: major,
                                            icon: const Icon(
                                              Icons.arrow_drop_down,
                                            ),
                                            iconSize: screenWidth * 0.04,
                                            underline: Container(
                                              height: screenHeight * 0.001,
                                              color: Colors.black,
                                            ),
                                            style:
                                                DropdownTextStyle(screenWidth),
                                            items: majorList,
                                            onChanged: (newVal) {
                                              setState(
                                                () {
                                                  major = newVal;
                                                  data.major = newVal!.title;
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showBottomDatePicker(screenWidth);
                                      },
                                      child: SizedBox(
                                        width: screenWidth * 0.8,
                                        height: screenWidth * 0.08,
                                        child: Row(
                                          children: [
                                            Text(
                                              "생년월일: ",
                                              style: TextStyle(
                                                fontFamily: "Nanum_Ogbice",
                                                fontSize: screenWidth * 0.048,
                                              ),
                                            ),
                                            (!isDateSelected)
                                                ? Text(
                                                    "선택하기",
                                                    style: TextStyle(
                                                      shadows: const [
                                                        Shadow(
                                                          offset: Offset(0, -1),
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                      color: Colors.transparent,
                                                      fontFamily:
                                                          "Nanum_Ogbice",
                                                      fontSize:
                                                          screenWidth * 0.04,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor:
                                                          Colors.black,
                                                    ),
                                                  )
                                                : Text(
                                                    "${data.birthDate.toString().substring(0, 4)}년 / "
                                                    "${data.birthDate.toString().substring(4, 6)}월 / "
                                                    "${data.birthDate.toString().substring(6, 8)}일",
                                                    style: TextStyle(
                                                      shadows: const [
                                                        Shadow(
                                                          offset: Offset(0, -3),
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                      color: Colors.transparent,
                                                      fontFamily:
                                                          "Nanum_Ogbice",
                                                      fontSize:
                                                          screenWidth * 0.04,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor:
                                                          Colors.black,
                                                    ),
                                                  ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: screenWidth * 0.01,
                                              ),
                                            ),
                                            (!isDateSelected)
                                                ? Icon(
                                                    Icons.check_circle_outline,
                                                    size: screenWidth * 0.03,
                                                  )
                                                : Icon(
                                                    Icons.check_circle,
                                                    size: screenWidth * 0.03,
                                                  )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.8,
                                      height: screenWidth * 0.07,
                                      child: Row(
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Text(
                                            "  키:  ",
                                            style: TextStyle(
                                              fontFamily: "Nanum_Ogbice",
                                              fontSize: screenWidth * 0.05,
                                            ),
                                          ),
                                          // Padding(padding: EdgeInsets.only(left:screenWidth*0.056)),
                                          SizedBox(
                                            width: screenWidth * 0.12,
                                            height: screenWidth * 0.1,
                                            //입력 칸 너비,높이 조절
                                            child: MyFormField(
                                              key: const ValueKey(1),
                                              hintText: "입력",
                                              textInputAction:
                                                  TextInputAction.next,
                                              screenWidth: screenWidth,
                                              validator: (val) {
                                                if (val == '' || val == null) {
                                                  return "필수입력";
                                                }
                                                return null;
                                              },
                                              onSaved: (val) {
                                                setState(
                                                  () {
                                                    data.height =
                                                        double.parse(val)
                                                            .round();
                                                  },
                                                );
                                              },
                                              inputFormatters: [
                                                FilteringTextInputFormatter(
                                                    RegExp('[0-9.]'),
                                                    allow: true)
                                              ],
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
                                    SizedBox(
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
                                              key: const ValueKey(2),
                                              hintText: "1.인스타",
                                              textInputAction:
                                                  TextInputAction.next,
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
                                    SizedBox(
                                      width: screenWidth * 0.5,
                                      height: screenWidth * 0.07,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          left: screenWidth * 0.09,
                                        ),
                                        child: MyFormField(
                                          key: const ValueKey(3),
                                          hintText: "2.카카오",
                                          textInputAction: TextInputAction.next,
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
                                    SizedBox(
                                      width: screenWidth * 0.5,
                                      height: screenWidth * 0.07,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          left: screenWidth * 0.09,
                                        ),
                                        child: MyFormField(
                                          key: const ValueKey(4),
                                          hintText: "3.전화번호",
                                          textInputAction: TextInputAction.done,
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
                                    Text(
                                      "*SNS는 셋 중 하나 이상 필수로 입력해주세요.",
                                      style: TextStyle(
                                        fontSize: 0.03 * screenWidth,
                                        fontFamily: "Nanum_Ogbice",
                                        color:
                                            const Color.fromRGBO(255, 0, 0, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Wrap(
                          spacing: 5,
                          children: [
                            Checkbox(
                              value: isAgree,
                              onChanged: (value) {
                                setState(() {
                                  isAgree = value!;
                                });
                              },
                              activeColor: Colors.transparent,
                              checkColor: Colors.black,
                            ),
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  for (int i = 0; i < linkTextItems.length; i++)
                                    getTextSpan(linkTextItems[i], screenWidth)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenWidth * 0.05,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          fixedSize: Size(
                            screenWidth * 0.3,
                            screenWidth * 0.1,
                          ),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 0.5,
                          ),
                          backgroundColor:
                              const Color.fromRGBO(255, 255, 255, 1),
                          shadowColor: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                        child: Center(
                          child: Text(
                            "작성 완료",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.038,
                              fontFamily: "Nanum_Ogbice",
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save(); //키 제대로 입력 시 저장.
                            if (data.sex != genderList[0] && //나머지 조건들 한 번 더 체크
                                data.college != collegeList[0].value!.title &&
                                data.major != "선택하기" &&
                                isDateSelected &&
                                isAgree &&
                                (data.instaId != '' ||
                                    data.kakaoId != '' ||
                                    data.phoneNumber != '')) {
                              data.age = AgeCalculation(
                                  data.birthDate.toString().substring(2, 8));
                              // print("필수 입력 요건이 충족됨");
                              // api 요청
                              final result = await sendUserProfileData(data);
                              if (result == "CompletedRegister") {
                                // 개인 정보 등록 완료
                                if (!mounted) return;
                                registrationCompletionNotify(context);
                              } else {
                                // 그 외- > 로그인 페이지로
                                if (!mounted) return;
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              }
                            } else {
                              //print("필수 입력 조건이 충족되지 않음");
                              alertRequiredInput(context, screenWidth);
                            }
                          } else {
                            // print("필수 입력 조건이 충족되지 않음");
                            alertRequiredInput(context, screenWidth);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showBottomDatePicker(double screenWidth) {
    BottomPicker.date(
      title: "생년월일을 입력해주세요!",
      titleStyle: TextStyle(
        fontFamily: "Nanum_Ogbice",
        fontSize: screenWidth * 0.05,
      ),
      onSubmit: (index) {
        setState(() {
          data.birthDate =
              index.toString().replaceAll(RegExp('[^0-9]'), "").substring(0, 8);
          isDateSelected = true;
        });
      },
      buttonSingleColor: Colors.black,
      maxDateTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      initialDateTime: DateTime(2000, 1, 1),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
    ).show(context);
  }
}
