import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssu_meet/dept_data/Majors.dart';

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
  List<String> gender = ['선택하기', '남', '여'];
  List<DropdownMenuItem<Item>> colleges = List.empty(growable: true);
  List<DropdownMenuItem<Item>> majors = List.empty(growable: true);
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
                  const Image(
                      image:
                          AssetImage("assets/images/images2/yellowpostit.png"),
                      width: 350,
                      height: 350),
                  const Positioned(
                    left: 135,
                    top: 10,
                    child: Image(
                      image: AssetImage("assets/images/images2/tape10.png"),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 47,
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
                              items: gender.map<DropdownMenuItem<String>>(
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
                              padding: EdgeInsets.only(left: 10),
                            ),
                            const Text(
                              "나이:",
                              style: TextStyle(
                                  fontFamily: "Nanum_Ogbice", fontSize: 23),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 5),
                            ),
                            SizedBox(
                              width: 85,
                              height: 30,
                              child: TextField(
                                decoration: myInputDecoration("나이 입력"),
                                cursorWidth: 1.5,
                                cursorHeight: 12,
                                cursorColor: Colors.black,
                                style: const TextStyle(
                                    fontSize: 22, fontFamily: "Nanum_Ogbice", color: Colors.black),
                                onChanged: (val){
                                  setState(() {
                                    _age=int.parse(val);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(children: [
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
                              items: colleges,
                              onChanged: (Item? newVal) {
                                setState(() {
                                  _college = newVal;
                                  majors = Majors(newVal!.ind).majors;
                                  _major = majors[0].value;
                                });
                              },
                            ),
                          )
                        ]),
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
                            items: majors,
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
                              height: 23,
                              child: TextField(
                                decoration: myInputDecoration("입력하기"),
                                cursorWidth: 1.5,
                                cursorHeight: 12,
                                cursorColor: Colors.black,
                                style: const TextStyle(
                                    fontSize: 22, fontFamily: "Nanum_Ogbice", color: Colors.black),
                                onChanged: (val){
                                  setState(() {
                                    _height=int.parse(val);
                                  });
                                },
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
                                height: 24, //입력 칸 높이 조절
                                child: TextField(
                                  decoration: myInputDecoration("입력하기"),
                                  cursorWidth: 1.5,
                                  cursorHeight: 12,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(
                                      fontSize: 22, fontFamily: "Nanum_Ogbice", color: Colors.black),
                                  onChanged: (val){
                                    setState(() {
                                      _contact=val;
                                    });
                                  },
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
              const Padding(padding: EdgeInsets.only(top: 30)),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    print(
                        "\n성별: $_gender\n나이: $_age\n학과: ${_college!.title} ${_major!.title}\n키: $_height\nSNS: $_contact\n");
                  },
                  child: Container(
                    width: 96,
                    height: 41,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/images/images2/submit3x.png"),
                          fit: BoxFit.fill),
                    ),
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
InputDecoration myInputDecoration(String hint){
  return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 19),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
    );

}


