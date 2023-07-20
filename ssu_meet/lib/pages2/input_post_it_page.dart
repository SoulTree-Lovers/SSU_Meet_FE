import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputPostIt extends StatefulWidget {
  const InputPostIt({super.key});

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
  List<String> ideal_list = [];

  final formKey = GlobalKey<FormState>();
  String? _nikname;
  String? _mbti;
  String? _hobby;
  String? _myself;

  @override
  void initState() {
    super.initState();
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
                    color: Colors.black12,
                    width: screenHeight * 0.002,
                  ),
                ),
                image: const DecorationImage(
                  image: AssetImage(
                    "assets/images/images2/appbar.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenWidth * 2,
          decoration: const BoxDecoration(
            image: DecorationImage(
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
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.07,
                  ),
                ),
                Text(
                  "자신을 소개할 내용을 등록해주세요!",
                  style: TextStyle(
                    fontFamily: "Nanum_Ogbice",
                    fontSize: screenWidth * 0.08,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.02,
                  ),
                ),
                Text(
                  "*추후 수정이 불가하니 신중히 입력 바랍니다.",
                  style: TextStyle(
                    fontFamily: "Nanum_Ogbice",
                    fontSize: screenWidth * 0.048,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: screenWidth * 0.07,
                  ),
                ),
                Stack(
                  children: [
                    Image(
                      width: screenWidth * 0.9,
                      height: screenWidth,
                      image: const AssetImage(
                        "assets/images/images2/yellowpostit2.png",
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: screenWidth * 0.07,
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
                    onTap: () {},
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
