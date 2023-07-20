import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssu_meet/dept_data/temp_majors.dart';

class InputProfile extends StatefulWidget {
  const InputProfile({super.key});

  @override
  State<StatefulWidget> createState() => _InputProfile();
}

class _InputProfile extends State<InputProfile> {
  List<String> gender = ["선택하기", '남', '여'];
  List<DropdownMenuItem<Item>> colleges = List.empty(growable: true);
  List<DropdownMenuItem<Item>> majors = List.empty(growable: true);
  List<String> contacts = ['', '', '']; //연락처(인스타, 카카오, 전화번호)

  final formKey = GlobalKey<FormState>();

  String? _gender; //성별
  Item? _college; //단과대
  Item? _major; //전공
  int? _height; //키
  int? _age; //나이

  @override
  void initState() {
    super.initState();
    _gender = gender[0];
    colleges = Colleges().colleges;
    _college = colleges[0].value;
    majors = Majors(0).majors;
    _major = majors[0].value;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.17),
        child: SizedBox(
          width: screenWidth,
          height: screenHeight * 0.17,
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            elevation: 0.0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: Colors.black12, width: screenHeight * 0.002),
                ),
                image: const DecorationImage(
                    image: AssetImage("assets/images/images2/appbar.png"),
                    fit: BoxFit.fill),
              ),
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
                                            value: _gender,
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
                                            items: gender
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
                                                  _gender = newVal!;
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
                                            value: _college,
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            iconSize: screenWidth * 0.04,
                                            underline: Container(
                                                height: screenHeight * 0.001,
                                                color: Colors.black),
                                            style:
                                                DropdownTextStyle(screenWidth),
                                            items: colleges,
                                            onChanged: (Item? newVal) {
                                              setState(
                                                () {
                                                  _college = newVal;
                                                  majors = Majors(newVal!.ind)
                                                      .majors;
                                                  _major = majors[0].value;
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
                                            value: _major,
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            iconSize: screenWidth * 0.04,
                                            underline: Container(
                                                height: screenHeight * 0.001,
                                                color: Colors.black),
                                            style:
                                                DropdownTextStyle(screenWidth),
                                            items: majors,
                                            onChanged: (newVal) {
                                              setState(
                                                () {
                                                  _major = newVal;
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
                                            "나이:",
                                            style: TextStyle(
                                                fontFamily: "Nanum_Ogbice",
                                                fontSize: screenWidth * 0.05),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: screenWidth * 0.024),
                                          ),
                                          SizedBox(
                                            width: screenWidth * 0.16,
                                            //입력칸 너비 조절
                                            child: MyFormField(
                                              key: const ValueKey(1),
                                              hintText: "만 나이 입력",
                                              screenWidth: screenWidth,
                                              validator: (val) {
                                                if (val == '' || val!.isEmpty) {
                                                  return "필수입력";
                                                }
                                                return null;
                                              },
                                              onSaved: (val) {
                                                setState(() {
                                                  _age = int.parse(val);
                                                });
                                              },
                                            ),
                                          ),
                                          Text(
                                            " 세",
                                            style: TextStyle(
                                              fontFamily: "Nanum_Ogbice",
                                              fontSize: screenWidth * 0.04,
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
                                            width: screenWidth * 0.13,
                                            //입력 칸 너비 조절
                                            child: MyFormField(
                                              key: const ValueKey(2),
                                              hintText: "입력하기",
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
                                                    _height = int.parse(val);
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Text(
                                            " cm",
                                            style: TextStyle(
                                              fontFamily: "Nanum_Ogbice",
                                              fontSize: screenWidth * 0.04,
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
                                              validator: (val) {
                                                if (val != '') {
                                                  //유효한 경우
                                                  contacts[0] = val;
                                                }
                                              },
                                              screenWidth: screenWidth,
                                              onSaved: (val) {
                                                setState(
                                                  () {
                                                    contacts[0] = val;
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
                                          validator: (val) {
                                            if (val != '') {
                                              contacts[1] = val;
                                            }
                                          },
                                          onSaved: (val) {
                                            setState(
                                              () {
                                                contacts[1] = val;
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
                                          validator: (val) {
                                            if (contacts[0] != '' ||
                                                contacts[1] != '' ||
                                                val != '') {
                                              contacts[2] = val;
                                              return null;
                                            }
                                          },
                                          onSaved: (val) {
                                            setState(
                                              () {
                                                contacts[2] = val;
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
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(5),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: screenWidth * 0.2,
                                height: screenWidth * 0.08,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.asset(
                                    "assets/images/images2/submit2.png",
                                  ),
                                ),
                              ),
                              Positioned(
                                left: screenWidth * 0.033,
                                top: screenWidth * 0.01,
                                child: Text(
                                  "작성 완료",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.045,
                                    fontFamily: "Nanum_Ogbice",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              /*다음 단계로 넘어가기 전, sns 한번 더 if문으로 검사 필요
                        if(contacts[0]!=''||contacts[1]!=''||contacts[2]!='')
                        ---->>넘어갈 수 있음
                        */
                            } else {
                              print("필수 입력 조건이 충족되지 않음"); //필수 입력 값을 다시 초기화
                              _height = null;
                              _age = null;
                              contacts = ['', '', ''];
                            }
                            print(
                                "성별: $_gender\n나이: $_age\n학과: ${_college!.title} ${_major!.title}\n키: $_height\n"
                                "SNS: (인스타: ${contacts[0]} 카카오: ${contacts[1]} 전화번호: ${contacts[2]})\n");
                          },
                        ),
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
