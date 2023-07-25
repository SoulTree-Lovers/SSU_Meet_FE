import 'package:flutter/material.dart';
import 'package:ssu_meet/pages2/select_idealtype_modal.dart';


String? _nikname;
String? _mbti;
String? _hobby;
String? _myself;

class InputPostIt extends StatefulWidget {
  const InputPostIt({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _InputPostIt();
}

class _InputPostIt extends State<InputPostIt> {
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

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: screenWidth * 0.05)),
              Text('자신을 소개할 내용을 등록해주세요!',
                  style: TextStyle(
                      fontFamily: "Nanum_Ogbice", fontSize: screenWidth * 0.06),
                  textAlign: TextAlign.center),
              Padding(padding: EdgeInsets.only(top: screenWidth * 0.02)),
              Text('*추후 수정이 불가하니 신중히 입력 바랍니다.',
                  style: TextStyle(
                      fontFamily: "Nanum_Ogbice", fontSize: screenWidth * 0.04),
                  textAlign: TextAlign.center),
              Padding(padding: EdgeInsets.only(top: screenWidth * 0.03)),
              Stack(
                children: [
                  const Image(
                    image: AssetImage(
                      "assets/images/images2/yellowpostit2.png",
                    ),
                  ),
                  //텍스트
                  Positioned(
                      top: screenWidth * 0.17,
                      left: screenWidth * 0.12,
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
                                    width: screenWidth * 0.45,
                                    height: screenWidth * 0.1,
                                    child: MyFormField(
                                      key: const ValueKey(1),
                                      hintText: "10자 이내",
                                      screenWidth: screenWidth,
                                      maxLength: 10,
                                      maxLine: 1,
                                      validator: (val) {
                                        if (val.length <= 10 && val != '') {
                                          return null;
                                        } else {
                                          return " ";
                                        }
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
                                            height: screenWidth * 0.001,
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
                                      width: screenWidth * 0.45,
                                      height: screenWidth * 0.15,
                                      child: MyFormField(
                                        key: const ValueKey(2),
                                        hintText: "50자 이내",
                                        screenWidth: screenWidth,
                                        maxLine: null,
                                        maxLength: 50,
                                        validator: (val) {
                                          if (val.length <= 50 && val != '') {
                                            return null;
                                          } else {
                                            return " ";
                                          }
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
                                      width: screenWidth * 0.44,
                                      height: screenWidth * 0.15,
                                      child: MyFormField(
                                        key: const ValueKey(3),
                                        hintText: "200자 이내",
                                        screenWidth: screenWidth,
                                        maxLine: null,
                                        maxLength: 200,
                                        validator: (val) {
                                          if (val.length <= 200 && val != '') {
                                            return null;
                                          } else {
                                            return " ";
                                          }
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "이상형:  ",
                                    style: TextStyle(
                                        fontFamily: "Nanum_Ogbice",
                                        fontSize: screenWidth * 0.045),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromRGBO(
                                          217, 239, 195, 1.0),
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const SelectIdealType();
                                          });
                                    },
                                    child: Text(
                                      "이상형 선택하기!",
                                      style: TextStyle(
                                          fontFamily: "Nanum_Ogbice",
                                          fontSize: screenWidth * 0.04,
                                          color: Colors.black),
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
                      fixedSize: Size(screenWidth * 0.19, screenWidth * 0.06),
                      side: const BorderSide(color: Colors.black, width: 0.5),
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
                    ),
                    child: Text(
                      "작성 완료",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.042,
                          fontFamily: "Nanum_Ogbice"),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                      } else {
                        print("값이 유효하지 않음"); //필수 입력 값을 다시 초기화
                      }
                      print("닉네임: $_nikname\nmbti: $_mbti\n취미: $_hobby\n자기소개: $_myself\n");

                      //Post New posiit
                    },
                  ),
                  const Padding(padding: EdgeInsets.only(left: 20)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth * 0.19, screenWidth * 0.06),
                      side: const BorderSide(color: Colors.black, width: 0.5),
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      shadowColor: const Color.fromRGBO(0, 0, 0, 0.25),
                    ),
                    child: Text(
                      "작성 취소",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.042,
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
    );
  }
}

class MyFormField extends StatefulWidget {
  final String hintText;
  final double screenWidth;
  final FormFieldValidator? validator;
  final FormFieldSetter? onSaved;
  final int maxLength;
  final int? maxLine;

  const MyFormField({
    Key? key,
    required this.hintText,
    required this.screenWidth,
    required this.maxLength,
    required this.maxLine,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  State<MyFormField> createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      maxLines: widget.maxLine,
      maxLength: widget.maxLength,
      cursorWidth: 1.5,
      cursorHeight: widget.screenWidth * 0.03,
      cursorColor: Colors.transparent,
      style: TextStyle(
        fontSize: widget.screenWidth * 0.04,
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
          borderSide:
              BorderSide(color: Colors.black, width: widget.screenWidth * 0.0015),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Colors.black, width: widget.screenWidth * 0.0015),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
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
      controller: _textController,
      onChanged: (text) {
        if (text.length > widget.maxLength) {
          // 최대 글자 수를 넘으면 입력을 막습니다.
          _textController.text = text.substring(0, widget.maxLength);
          _textController.selection = TextSelection.fromPosition(
            TextPosition(offset: _textController.text.length),
          );
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
