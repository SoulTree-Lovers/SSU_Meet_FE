import 'package:flutter/material.dart';
import 'package:ssu_meet/pages2/select_idealtype_modal.dart';
import 'package:ssu_meet/widgets/custom_textformfield_with_limit_letters.dart';

class InputPostIt extends StatefulWidget {
  const InputPostIt({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InputPostIt();
}

class _InputPostIt extends State<InputPostIt> {
  final formKey = GlobalKey<FormState>();
  String? _nikname;
  String? _mbti;
  String? _hobby;
  String? _myself;
  List ideal_list = [];
  int flag = 0;

  List<String> mbti_list = [
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
   // double screenHeight = MediaQuery.of(context).size.height;
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
                Padding(padding: EdgeInsets.only(top: screenWidth * 0.05)),
                Text('자신을 소개할 내용을 등록해주세요!',
                    style: TextStyle(
                        fontFamily: "Nanum_Ogbice",
                        fontSize: screenWidth * 0.06),
                    textAlign: TextAlign.center),
                Padding(padding: EdgeInsets.only(top: screenWidth * 0.02)),
                Text('*추후 수정이 불가하니 신중히 입력 바랍니다.',
                    style: TextStyle(
                        fontFamily: "Nanum_Ogbice",
                        fontSize: screenWidth * 0.04),
                    textAlign: TextAlign.center),
                Padding(padding: EdgeInsets.only(top: screenWidth * 0.03)),
                Stack(
                  children: [
                     Image(
                      image: const AssetImage(
                        "assets/images/images2/yellowpostit2.png",
                      ),
                      width: screenWidth * 0.85,
                       height: screenWidth * 1.1 ,
                    ),
                    //텍스트
                    Positioned(
                      top: screenWidth * 0.23,
                      left: screenWidth * 0.1,
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
                                        fontSize: screenWidth * 0.045),
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
                                        if (val == '' || val!.isEmpty) {
                                          return "필수입력";
                                        }
                                        return null;
                                      },
                                      onSaved: (val) {
                                        setState(() {
                                          _nikname = val;
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
                                        fontSize: screenWidth * 0.045),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.2,
                                    height: screenWidth * 0.08,
                                    child: DropdownButton(
                                      alignment: Alignment.center,
                                      value: _mbti,
                                      underline: Container(
                                          height: screenWidth * 0.0015,
                                          color: Colors.black),
                                      style: TextStyle(
                                        fontFamily: "Nanum_Ogbice",
                                        fontSize: screenWidth * 0.045,
                                        color: Colors.black,
                                      ),
                                      hint: Text("선택하기",
                                          style: TextStyle(
                                            fontFamily: "Nanum_Ogbice",
                                            fontSize: screenWidth * 0.04,
                                          )),
                                      items: mbti_list
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
                                          _mbti = newVal;
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
                                        fontSize: screenWidth * 0.045),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.4,
                                    height: screenWidth * 0.15,
                                    child: MyFormField(
                                      key: const ValueKey(2),
                                      hintText: "50자 이내",
                                      screenWidth: screenWidth,
                                      maxLine: null,
                                      maxLength: 50,
                                      validator: (val) {
                                        if (val == '' || val!.isEmpty) {
                                          return "필수입력";
                                        }
                                        return null;
                                      },
                                      onSaved: (val) {
                                        setState(() {
                                          _hobby = val;
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
                                    "자기소개: ",
                                    style: TextStyle(
                                        fontFamily: "Nanum_Ogbice",
                                        fontSize: screenWidth * 0.045),
                                  ),
                                  SizedBox(
                                      width: screenWidth * 0.4,
                                      height: screenWidth * 0.15,
                                      child: MyFormField(
                                        key: const ValueKey(3),
                                        hintText: "200자 이내",
                                        screenWidth: screenWidth,
                                        maxLine: null,
                                        maxLength: 200,
                                        validator: (val) {
                                          if (val == '' || val!.isEmpty) {
                                            return "필수입력";
                                          }
                                          return null;
                                        },
                                        onSaved: (val) {
                                          setState(() {
                                            _myself = val;
                                          });
                                        },
                                        //maxLength: 200,
                                      )),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "이상형:  ",
                                    style: TextStyle(
                                        fontFamily: "Nanum_Ogbice",
                                        fontSize: screenWidth * 0.045),
                                  ),
                                  Offstage(
                                    offstage: (flag == 0) ? false : true,
                                    child: SizedBox(
                                      //height: screenWidth * 0.09,
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50)),
                                                  fixedSize: Size(
                                                      screenWidth * 0.3,
                                                      screenWidth * 0.05)),
                                              onPressed: () {
                                                showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return SelectIdealType();
                                                  },
                                                );
                                              },
                                              child: Text(
                                                "  이상형 선택하기!",
                                                style: TextStyle(
                                                    fontFamily: "Nanum_Ogbice",
                                                    fontSize:
                                                        screenWidth * 0.03,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                           Positioned(
                                             top:screenWidth * -0.007,
                                             width: screenWidth * 0.08,
                                             height: screenWidth * 0.08,
                                             child:const Image(
                                                 image: AssetImage(
                                                    "assets/images/images2/whiteheart2.png")),
                                           ),
                                        ],
                                      ),
                                      //이상형 리스트...
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: screenWidth * 0.04)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(screenWidth * 0.22, screenWidth * 0.05),
                        side: const BorderSide(color: Colors.black, width: 0.5),
                        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                        shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
                      ),
                      child: Text(
                        "작성 완료",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.035,
                            fontFamily: "Nanum_Ogbice"),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate() && _mbti != null) {
                          formKey.currentState!.save();
                          print(
                              "닉네임: $_nikname\nmbti: $_mbti\n취미: $_hobby\n자기소개: $_myself\n이상형: ");
                          Navigator.pop(context);
                        } else {
                          print("값이 유효하지 않음");
                        }

                        //Post New posiit
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(screenWidth * 0.22, screenWidth * 0.05),
                        side: const BorderSide(color: Colors.black, width: 0.5),
                        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                        shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
                      ),
                      child: Text(
                        "작성 취소",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.035,
                            fontFamily: "Nanum_Ogbice"),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
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

