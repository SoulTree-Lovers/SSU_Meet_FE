import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssu_meet/dept_data/temp_majors.dart';

/*class PersonProfile{
  String _gender = '';
  Item? _college;
  Item? _major;
  int? _height;
  int? _age; /////////
  String? _contact;

  PersonProfile(String gender, int age,Item college,Item major, int height, String contact){
    _gender=gender;
    _age=age;
    _college=college;
    _major=major;
    _height=height;
    _contact=contact;
  }
}*/

class InputProfile extends StatefulWidget {
  const InputProfile({super.key});

  @override
  State<StatefulWidget> createState() => _InputProfile();
}

class _InputProfile extends State<InputProfile> {
  List<String> gender = ["선택하기", '남', '여'];
  List<DropdownMenuItem<Item>> colleges = List.empty(growable: true);
  List<DropdownMenuItem<Item>> majors = List.empty(growable: true);
  List<String> contacts = [];

  final formKey = GlobalKey();

  //List<DropdownMenuItem<ListTile>> contacts = List.empty(growable: true);

  String _gender = '';
  Item? _college;
  Item? _major;
  int? _height;
  int? _age;
  String? _contact;

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
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          //배경이미지
          image: DecorationImage(
              image: AssetImage("assets/images/images2/paper.png"),
              fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
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
                      fontFamily: "Nanum_Ogbice", fontSize: screenWidth * 0.1),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.02),
                ),
                Text(
                  "*구매할 경우 보이는 정보입니다.",
                  style: TextStyle(
                      fontFamily: "Nanum_Ogbice", fontSize: screenWidth * 0.05),
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
                          image: AssetImage("assets/images/images2/tape10.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      //텍스트 위치 조정
                      top: screenWidth * 0.1,
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
                                height: screenWidth * 0.1,
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
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: screenWidth * 0.04,
                                      style: DropdownTextStyle(screenWidth),
                                      alignment: Alignment.center,
                                      underline: Container(
                                        height: screenWidth * 0.001, //밑줄두께
                                        color: Colors.black,
                                      ),
                                      items:
                                          gender.map<DropdownMenuItem<String>>(
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
                                height: screenWidth * 0.1,
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
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: screenWidth * 0.04,
                                      underline: Container(
                                          height: screenHeight * 0.001,
                                          color: Colors.black),
                                      style: DropdownTextStyle(screenWidth),
                                      items: colleges,
                                      onChanged: (Item? newVal) {
                                        setState(
                                          () {
                                            _college = newVal;
                                            majors = Majors(newVal!.ind).majors;
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
                                height: screenWidth * 0.1,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * 0.095),
                                    ),
                                    DropdownButton<Item>(
                                      value: _major,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconSize: screenWidth * 0.04,
                                      underline: Container(
                                          height: screenHeight * 0.001,
                                          color: Colors.black),
                                      style: DropdownTextStyle(screenWidth),
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
                                height: screenWidth * 0.06,
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
                                      width: screenWidth * 0.16, //입력 밑줄 길이 조절
                                      child: MyFormField(
                                        key: const ValueKey(2),
                                        hintText: "만 나이 입력",
                                        screenWidth: screenWidth,
                                        validator: (val) {
                                          if (val == null) return ("필수 입력");
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
                                      width: screenWidth * 0.13, //입력 밑줄 길이 조절
                                      child: MyFormField(
                                        key: const ValueKey(2),
                                        hintText: "입력하기",
                                        screenWidth: screenWidth,
                                        validator: (val) {
                                          if (val == null) return ("필수 입력");
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
                                        hintText: "1.인스타(임시)",
                                        screenWidth: screenWidth,
                                        validator: (val) {
                                          if (val == null) return ("필수 입력");
                                          return null;
                                        },
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
                                    key: const ValueKey(3),
                                    hintText: "2.카카오(임시)",
                                    screenWidth: screenWidth,
                                    validator: (val) {
                                      if (val == null) return ("필수 입력");
                                      return null;
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
                                    key: const ValueKey(3),
                                    hintText: "3.번호(임시)",
                                    screenWidth: screenWidth,
                                    validator: (val) {
                                      if (val == null) return ("필수 입력");
                                      return null;
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
                            Padding(
                              padding: EdgeInsets.only(
                                top: screenWidth * 0.01,
                              ),
                            ),
                            Text(
                              "셋 중 하나 이상 필수로 입력해주세요.",
                              style: TextStyle(
                                fontSize: 0.02 * screenWidth,
                                color: Colors.teal,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: screenWidth * 0.1,
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      print(
                          "\n성별: $_gender\n나이: $_age\n학과: ${_college!.title} ${_major!.title}\n키: $_height\nSNS: $_contact\n");
                    },
                    child: Container(
                      width: screenWidth * 0.2,
                      height: screenWidth * 0.1,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/images2/submit3x.png",
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "완료",
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontFamily: "Nanum_Ogbice",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: screenWidth * 0.04,
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
      autovalidateMode: AutovalidateMode.always,
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
