import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssu_meet/dept_data/Majors.dart';

class InputProfile extends StatefulWidget {
  const InputProfile({super.key});

  @override
  State<StatefulWidget> createState() => _InputProfile();
}

class _InputProfile extends State<InputProfile> {
  List<String> Gender = ['선택하기', '남', '여'];
  List<int> Age = [];
  List<DropdownMenuItem<Item>> _Colleges = List.empty(growable: true);
  List<DropdownMenuItem<Item>> _Majors = List.empty(growable: true);
  List<DropdownMenuItem<ListTile>> Contacts = List.empty(growable: true);

  String _gender = '';
  Item? _college;
  Item? _major;
  int? _height;
  int? _age; /////////
  String? _contact;

  @override
  void initState() {
    super.initState();
    _gender = Gender[0];
    for (int i = 1990; i <= 2023; i++) {
      Age.add(i);
    }
    _Colleges = Colleges().colleges;
    _college = _Colleges[0].value;
    _Majors = Majors(0).majors;
    _major = _Majors[0].value;
    //////////////
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(127),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 127,
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            elevation: 0.0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black12, width: 1.5)),
                image: DecorationImage(
                    image: AssetImage("assets/images/images2/appbar.png"),
                    fit: BoxFit.fill),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              //배경이미지
              image: DecorationImage(
                  image: AssetImage("assets/images/images2/paper.png"),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 60)),
              const Text("기본 정보를 등록해주세요!",
                  style: TextStyle(fontFamily: "Nanum_Ogbice", fontSize: 35)),
              const Padding(padding: EdgeInsets.only(top: 15)),
              const Text("*구매할 경우 보이는 정보입니다.",
                  style: TextStyle(fontFamily: "Nanum_Ogbice", fontSize: 20)),
              //padding
              Stack(
                children: [
                  Container(
                    child: const Image(
                        image: AssetImage(
                            "assets/images/images2/yellowpostit.png"),
                        width: 350,
                        height: 350),
                  ),
                  const Positioned(
                    left: 135,
                    top: 10,
                    child: Image(
                      image: AssetImage("assets/images/images2/tape10.png"),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 50,
                    child: Wrap(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Row(
                          children: [
                            const Text(
                              "성별:",
                              style: TextStyle(
                                  fontFamily: "Nanum_Ogbice", fontSize: 23),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 18),
                            ),
                            DropdownButton<String>(
                              value: _gender,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 20,
                              style: myInputTextStyle(),
                              alignment: Alignment.center,
                              underline: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                              items: Gender.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newVal) {
                                setState(
                                  () {
                                    _gender = newVal!;
                                  },
                                );
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 18),
                            ),
                            const Text(
                              "나이:",
                              style: TextStyle(
                                  fontFamily: "Nanum_Ogbice", fontSize: 23),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 18),
                            ),
                            DropdownButton<int>(
                              value: _age,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 20,
                              style: myInputTextStyle(),
                              alignment: Alignment.center,
                              underline: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                              items:
                                  Age.map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(
                                    value.toString(),
                                  ),
                                );
                              }).toList(),
                              onChanged: (int? newVal) {
                                setState(
                                  () {
                                    _age = newVal!;
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        // ignore: avoid_unnecessary_containers
                        Container(
                            child: Row(children: [
                          const Text(
                            "학과:",
                            style: TextStyle(
                                fontFamily: "Nanum_Ogbice", fontSize: 22),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                          ),
                          SizedBox(
                            width: 180,
                            child: DropdownButton<Item>(
                              value: _college,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 20,
                              underline:
                                  Container(height: 1, color: Colors.black),
                              style: myInputTextStyle(),
                              items: _Colleges,
                              onChanged: (Item? newVal) {
                                setState(() {
                                  _college = newVal;
                                  _Majors = Majors(newVal!.ind).majors;
                                  _major = _Majors[0].value;
                                });
                              },
                            ),
                          )
                        ])),
                        Container(
                          width: 230,
                          padding: const EdgeInsets.only(left: 47),
                          child: DropdownButton<Item>(
                            value: _major,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 20,
                            underline:
                                Container(height: 1, color: Colors.black),
                            style: myInputTextStyle(),
                            items: _Majors,
                            onChanged: (newVal) {
                              setState(
                                () {
                                  _major = newVal;
                                },
                              );
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        Row(
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            const Text(
                              "키:",
                              style: TextStyle(
                                  fontFamily: "Nanum_Ogbice", fontSize: 23),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 29),
                            ),
                            SizedBox(
                              width: 70,
                              height: 21,
                              child: myFormField(
                                key: const ValueKey(1),
                                onSaved: (value) {
                                  setState(
                                    () {
                                      _height = value;
                                    },
                                  );
                                },
                                hintText: ("입력하기"),
                              ),
                            ),
                            const Text(
                              " cm",
                              style: TextStyle(
                                  fontFamily: "Nanum_Ogbice", fontSize: 20),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 3),
                          child: Row(
                            children: [
                              const Text(
                                "SNS:",
                                style: TextStyle(
                                    fontFamily: "Nanum_Ogbice", fontSize: 23),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 11),
                              ),
                              //연락처 종류 선택
                              /* DropdownButton<ListTile>(
                              items: _Contacts,
                              onChanged: (value) {
                                setState(() {});
                              }),*/
                              SizedBox(
                                width: 185,
                                height: 18,
                                child: myFormField(
                                  key: const ValueKey(1),
                                  onSaved: (value) {
                                    setState(
                                      () {
                                        _contact = value;
                                      },
                                    );
                                  },
                                  hintText: ("입력하기"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                // top: 500,
                child: InkWell(
                  onTap: () {
                    print(
                        "\n성별: $_gender\n 나이: $_age\n 학과: $_college $_major\n 키: $_height\n SNS: $_contact\n");
                  },
                  child: Container(
                    width: 96,
                    height: 41,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/images2/submit3x.png"),
                            fit: BoxFit.fill)),
                    child: const Center(
                      child: Text(
                        "완료",
                        style:
                            TextStyle(fontSize: 28, fontFamily: "Nanum_Ogbice"),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TextStyle myInputTextStyle() {
  return const TextStyle(
      fontFamily: "Nanum_Ogbice", fontSize: 20, color: Colors.black);
}

class myFormField extends StatelessWidget {
  final String hintText;
  final FormFieldSetter? onSaved;
  final FormFieldValidator? validator;

  const myFormField(
      {Key? key, required this.hintText, this.validator, this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      cursorColor: Colors.black,
      style: const TextStyle(
          fontSize: 19, fontFamily: "Nanum_Ogbice", color: Colors.black),
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
