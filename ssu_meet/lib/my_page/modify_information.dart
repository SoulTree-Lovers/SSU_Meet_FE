import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:ssu_meet/pages/login_page.dart';
import 'package:ssu_meet/dept_data/temp_majors.dart';
import '../dialogs/alert_required_input.dialog.dart';
import '../dialogs/modify_completed.dialog.dart';
import '../user_profile_data/user_profile.dart';
import 'package:ssu_meet/functions/age_calculation.dart';
import 'package:ssu_meet/widgets/dropdown_text_style.dart';
import 'package:ssu_meet/widgets/custom_textformfield.dart';

class ModifyPage extends StatefulWidget {
  const ModifyPage({super.key});

  @override
  State<ModifyPage> createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  List<String> genderList = [];
  List<DropdownMenuItem<Item>> collegeList = List.empty(growable: true);
  List<DropdownMenuItem<Item>> majorList = List.empty(growable: true);
  final formKey = GlobalKey<FormState>();
  Item? tmpCollege;
  Item? tmpMajor;
  var data;
  bool isLoading = false;
  bool isRegistered = true;

  Item? searchInItemList(String name, List<DropdownMenuItem<Item>> list) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].value!.title == name) return list[i].value;
    }
    return null;
  }

  // void getOldProfileLocal() async {
  //   /* api 연동- GET 요청 함수
  //   const url='http://localhost:8080/v1/members/mypage/modify';
  //   var response = await http.get(
  //     Uri.parse(url),
  //     headers: {"Authorization":"——"},
  //   );
  //   final responseData = json.decode(response.body);
  //   if (responseData["status"] == "SUCCESS") {
  //     print(responseData["message"]);
  //     var jsonString = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
  //   }
  //   else {
  //     print('Failed to get data. Error: ${response.statusCode}');
  //   } */
  //   print("함수 실행 완료");
  //   var jsonString = await rootBundle.loadString('json/old_profile.json');
  //   setState(() {
  //     data = UserProfile.fromJson(
  //         jsonDecode(jsonString)["data"] as Map<String, dynamic>);
  //     genderList.add(data.sex);
  //     collegeList = Colleges().colleges;
  //     tmpCollege = searchInItemList(data.college, collegeList);
  //     majorList = Majors(tmpCollege!.ind).majors;
  //     tmpMajor = searchInItemList(data.major, majorList);
  //     isLoading = true;
  //   });
  // }

  // api 연동- GET 요청 함수
  void getOldProfile() async {
    const url = 'http://43.202.77.44:8080/v1/members/mypage/modify';
    print("함수 실행");
    var accessToken = await storage.read(key: "access_token");

    if (accessToken == null) {
      // 미등록 사용자
      setState(() {
        isRegistered = false;
        isLoading = true;
      });
      return;
    }

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    print("응답 완료");

    if (response.statusCode == 200) {
      // 한글 깨짐 현상 해결: utf8.decode(response.bodyBytes)를 사용하여 입력받기
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));

      if (responseData["status"] == "SUCCESS") {
        print("status success");
        print(responseData["message"]);
        print("responseData: $responseData");
        print("responseData['data']: ${responseData["data"]}");
        var test = responseData["data"] as Map<String, dynamic>;

        print("test: $test");

        var localTest = {
          "sex": "FEMALE",
          "birthDate": "20020901",
          "age": 20,
          "college": "IT대학",
          "major": "소프트웨어학부",
          "height": 164,
          "instaId": null,
          "kakaoId": "kakaoID",
          "phoneNumber": "01012345678"
        };
        print("local test: $localTest");
        setState(() {
          // data = UserProfile.fromJson(
          //     responseData["data"] as Map<String, dynamic>);
          data = UserProfile.fromJson(test);
          print("fromJson 실행 후");
          genderList.add(data.sex);
          collegeList = Colleges().colleges;
          tmpCollege = searchInItemList(data.college, collegeList);
          majorList = Majors(tmpCollege!.ind).majors;
          tmpMajor = searchInItemList(data.major, majorList);
          isLoading = true;
        });
      }
    } else {
      print('Failed to get data. Error: ${response.statusCode}');
    }
  }

  // api 연동- 수정 완료 후 POST 요청 코드
  Future<void> sendModifiedProfileData(UserProfile newData) async {
    const url = 'http://43.202.77.44:8080/v1/members/mypage/modify';

    var accessToken = await storage.read(key: "access_token");

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: json.encode(newData.toJson()),
    );
    // 한글 깨짐 현상 해결: utf8.decode(response.bodyBytes)를 사용하여 입력받기
    final responseData = jsonDecode(utf8.decode(response.bodyBytes));

    if (responseData["status"] == "SUCCESS") {
      print(responseData["message"]);
    } else {
      print('Failed to get data. Error: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    // getOldProfileLocal();
    getOldProfile();
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
      body: (!isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : (!isRegistered)
              ? const Center(
                  child: Text(
                    '로그인 후 이용할 수 있습니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'NanumSquareRoundBold',
                      // fontWeight: FontWeight.w700,
                      // height: 1.31,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth,
                        height: screenHeight,
                        decoration: const BoxDecoration(
                          //배경이미지
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/images2/paper.png"),
                              fit: BoxFit.fill),
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
                                    fontSize: screenWidth * 0.1),
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
                                    fontSize: screenWidth * 0.05),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: screenHeight * 0.01,
                                ),
                              ),
                              Text(
                                "*성별, 생년월일은 수정 불가합니다.",
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
                                        "assets/images/images2/yellowpostit.png",
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Positioned(
                                    left: screenWidth * 0.33,
                                    top: screenWidth * -0.08,
                                    child: SizedBox(
                                      width: screenWidth * 0.3,
                                      height: screenWidth * 0.32,
                                      child: const Image(
                                        image: AssetImage(
                                          "assets/images/images2/tape10.png",
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    //텍스트 위치 조정
                                    top: screenWidth * 0.15,
                                    left: screenWidth * 0.2,
                                    child: SizedBox(
                                      width: screenWidth * 0.8,
                                      height: screenWidth * 0.8,
                                      child: Form(
                                        key: formKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              width: screenWidth * 0.8,
                                              height: screenWidth * 0.065,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "성별:  ",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Nanum_Ogbice",
                                                      fontSize:
                                                          screenWidth * 0.05,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      top: screenWidth * 0.01,
                                                    ),
                                                    width: screenWidth * 0.06,
                                                    height: screenWidth * 0.07,
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          color: Colors.black54,
                                                          width: screenWidth *
                                                              0.0015,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "${data.sex}",
                                                      style: TextStyle(
                                                        fontSize:
                                                            screenWidth * 0.05,
                                                        fontFamily:
                                                            "Nanum_Ogbice",
                                                        color: Colors.black54,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.8,
                                              height: screenWidth * 0.08,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "학과: ",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Nanum_Ogbice",
                                                        fontSize: screenWidth *
                                                            0.048),
                                                  ),
                                                  DropdownButton<Item>(
                                                    value: tmpCollege,
                                                    icon: const Icon(
                                                        Icons.arrow_drop_down),
                                                    iconSize:
                                                        screenWidth * 0.04,
                                                    underline: Container(
                                                        height: screenWidth *
                                                            0.0015,
                                                        color: Colors.black),
                                                    style: DropdownTextStyle(
                                                        screenWidth),
                                                    items: collegeList,
                                                    onChanged: (Item? newVal) {
                                                      setState(
                                                        () {
                                                          tmpCollege = newVal;
                                                          data.college =
                                                              newVal!.title;
                                                          majorList =
                                                              Majors(newVal.ind)
                                                                  .majors;
                                                          tmpMajor =
                                                              majorList[0]
                                                                  .value;
                                                          data.major =
                                                              tmpMajor!.title;
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.8,
                                              height: screenWidth * 0.08,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: screenWidth *
                                                            0.095),
                                                  ),
                                                  DropdownButton<Item>(
                                                    value: tmpMajor,
                                                    icon: const Icon(
                                                        Icons.arrow_drop_down),
                                                    iconSize:
                                                        screenWidth * 0.04,
                                                    underline: Container(
                                                        height: screenWidth *
                                                            0.0015,
                                                        color: Colors.black),
                                                    style: DropdownTextStyle(
                                                        screenWidth),
                                                    items: majorList,
                                                    onChanged: (newVal) {
                                                      setState(
                                                        () {
                                                          tmpMajor = newVal;
                                                          data.major =
                                                              newVal!.title;
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.8,
                                              height: screenWidth * 0.07,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "생년월일:",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Nanum_Ogbice",
                                                        fontSize:
                                                            screenWidth * 0.048,
                                                        color: Colors.black54),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left:
                                                            screenWidth * 0.02),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      top: screenWidth * 0.02,
                                                    ),
                                                    width: screenWidth * 0.35,
                                                    height: screenWidth * 0.1,
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          width: screenWidth *
                                                              0.0015,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "${data.birthDate.toString().substring(0, 4)}년 / "
                                                      "${data.birthDate.toString().substring(4, 6)}월 / "
                                                      "${data.birthDate.toString().substring(6, 8)}일",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Nanum_Ogbice",
                                                        fontSize:
                                                            screenWidth * 0.04,
                                                        color: Colors.black54,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.8,
                                              height: screenWidth * 0.09,
                                              child: Row(
                                                textBaseline:
                                                    TextBaseline.alphabetic,
                                                children: [
                                                  Text(
                                                    "  키: ",
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Nanum_Ogbice",
                                                      fontSize:
                                                          screenWidth * 0.05,
                                                    ),
                                                  ),
                                                  // Padding(padding: EdgeInsets.only(left:screenWidth*0.056)),
                                                  SizedBox(
                                                    width: screenWidth * 0.12,
                                                    height: screenWidth * 0.1,
                                                    //입력 칸 너비,높이 조절
                                                    child: MyFormField(
                                                      key: const ValueKey(2),
                                                      initText: data.height
                                                          .toString(),
                                                      hintText: "입력",
                                                      screenWidth: screenWidth,
                                                      textInputAction: TextInputAction.next,
                                                      validator: (val) {
                                                        if (val == '' ||
                                                            val == null) {
                                                          return "필수입력";
                                                        }
                                                        return null;
                                                      },
                                                      onSaved: (val) {
                                                        setState(
                                                          () {
                                                            data.height =
                                                                double.parse(
                                                                        val)
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
                                                      fontFamily:
                                                          "Nanum_Ogbice",
                                                      fontSize:
                                                          screenWidth * 0.035,
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
                                                      fontFamily:
                                                          "Nanum_Ogbice",
                                                      fontSize:
                                                          screenWidth * 0.05,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: MyFormField(
                                                      key: const ValueKey(2),
                                                      initText: data.instaId!,
                                                      hintText: "1.인스타",
                                                      textInputAction: TextInputAction.next,
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
                                                  initText: data.kakaoId!,
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
                                                  initText: data.phoneNumber!,
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
                                                color: const Color.fromRGBO(255, 0, 0, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: screenWidth * 0.02,
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  fixedSize: Size(
                                      screenWidth * 0.23, screenWidth * 0.08),
                                  side: const BorderSide(
                                      color: Colors.black, width: 0.5),
                                  backgroundColor:
                                      const Color.fromRGBO(255, 255, 255, 1),
                                  shadowColor: const Color.fromRGBO(0, 0, 0, 1),
                                ),
                                child: Center(
                                  child: Text(
                                    "수정 완료",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: screenWidth * 0.038,
                                        fontFamily: "Nanum_Ogbice"),
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    //키만 입력하면 키 저장.
                                    formKey.currentState!.save();
                                    if (data.college !=
                                            collegeList[0].value!.title &&
                                        data.major != "선택하기" &&
                                        (data.instaId != '' ||
                                            data.kakaoId != '' ||
                                            data.phoneNumber != '')) {
                                      data.age = AgeCalculation(data.birthDate
                                          .toString()
                                          .substring(2, 8));
                                      print("필수 입력 요건이 충족됨");
                                      // 변경된 값 보내기
                                      sendModifiedProfileData(data);
                                      //  print("수정 후 데이터");
                                      //   print(json.encode(data.toJson()));
                                      modificationCompletionNotify(context);
                                    } else {
                                      // print("필수 입력 조건이 충족되지 않음");
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
    );
  }
}
