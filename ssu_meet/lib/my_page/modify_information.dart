import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:ssu_meet/pages/login_page.dart';
import 'package:ssu_meet/dept_data/temp_majors.dart';
import '../dialogs/alert_required_input.dialog.dart';
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

  Item? searchInItemList(String name, List<DropdownMenuItem<Item>> list) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].value!.title == name) return list[i].value;
    }
    return null;
  }
// api 연동- GET 요청 함수
  void getOldProfile() async {
    const url = 'http://localhost:8080/v1/members/mypage/modify';

    var token = await storage.read(key: "token");

    var response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData["status"] == "SUCCESS") {
        print(responseData["message"]);
         setState(() {
      data = UserProfile.fromJson(jsonDecode(responseData)["data"] as Map<String, dynamic>);
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
  Future<void> sendModifiedProfileData (MyData newData) async{
    const url = 'http://localhost:8080/v1/members/mypage/modify';
    final response = await http.post(
      Uri.parse(url),
      headers: {"Authorization":"-----"},
      body: json.encode(newData.toJson()),
    );
    final responseData = json.decode(response.body);
    if(responseData["status"] == "SUCCESS"){
      print(responseData["message"]);
    }
    else{
      print('Failed to get data. Error: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    getOldProfile();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    if (!isLoading) return const Center(child: CircularProgressIndicator());
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
                height: screenWidth * 2.2,
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
                        "*성별, 생년월일은 수정 불가합니다.",
                        style: TextStyle(
                            fontSize: 0.025 * screenWidth, color: Colors.red),
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
                                                fontSize: screenWidth * 0.05,
                                                color: Colors.black54),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: screenWidth * 0.01),
                                            width: screenWidth * 0.06,
                                            height: screenWidth * 0.07,
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.black54)),
                                            ),
                                            child: Text(
                                              "${data.sex}",
                                              style: TextStyle(
                                                fontSize: screenWidth * 0.05,
                                                fontFamily: "Nanum_Ogbice",
                                                color: Colors.black54,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
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
                                                height: screenWidth * 0.0015,
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
                                                  data.major = tmpMajor!.title;
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
                                                height: screenWidth * 0.0015,
                                                color: Colors.black),
                                            style:
                                                DropdownTextStyle(screenWidth),
                                            items: majorList,
                                            onChanged: (newVal) {
                                              setState(
                                                () {
                                                  tmpMajor = newVal;
                                                  data.major = newVal!.title;
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
                                                fontSize: screenWidth * 0.05,
                                                color: Colors.black54),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: screenWidth * 0.02),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: screenWidth * 0.02),
                                            width: screenWidth * 0.16,
                                            height: screenWidth * 0.1,
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.black54)),
                                            ),
                                            child: Text(
                                              "${data.birth}",
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.05,
                                                  fontFamily: "Nanum_Ogbice",
                                                  color: Colors.black54),
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
                                          Flexible(
                                            child: SizedBox(
                                              width: screenWidth * 0.09,
                                              height: screenWidth * 0.1,
                                              //입력 칸 너비,높이 조절
                                              child: MyFormField(
                                                key: const ValueKey(2),
                                                initText:
                                                    data.height.toString(),
                                                hintText: "입력",
                                                screenWidth: screenWidth,
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
                                                          double.parse(val)
                                                              .round();
                                                    },
                                                  );
                                                },
                                              ),
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
                                              initText: data.instaId!,
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
                                          initText: data.kakaoId!,
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
                                          initText: data.phoneNumber!,
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
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenWidth * 0.07,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          fixedSize:
                              Size(screenWidth * 0.23, screenWidth * 0.08),
                          side:
                              const BorderSide(color: Colors.black, width: 0.5),
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
                            if (data.college != collegeList[0].value!.title &&
                                data.major != majorList[0].value!.title &&
                                (data.instaId != '' ||
                                    data.kakaoId != '' ||
                                    data.phoneNumber != '')) {
                              data.age = AgeCalculation(data.birth);
                              print("필수 입력 요건이 충족됨");
                              // 변경된 값 보내기
                              //  sendModifiedProfileData(data);
                              print("수정 후 데이터");
                              print(json.encode(data.toJson()));
                              Navigator.pop(context);
                            } else {
                              // print("필수 입력 조건이 충족되지 않음");
                              alertRequiredInput(context);
                            }
                          } else {
                            // print("필수 입력 조건이 충족되지 않음");
                            alertRequiredInput(context);
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
