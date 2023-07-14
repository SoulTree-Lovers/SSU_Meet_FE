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
  List<DropdownMenuItem<Item>> _Colleges = List.empty(growable: true);
  List<DropdownMenuItem<Item>> _Majors = List.empty(growable: true);
  List<DropdownMenuItem<ListTile>> Contacts = List.empty(growable: true);

  String _gender = '';
  Item? _college;
  Item? _major;
  int? _height;
  String? _contact;

  @override
  void initState() {
    super.initState();
    _gender = Gender[0];
    _Colleges = Colleges().colleges;
    _college = _Colleges[0].value;
    _Majors = Majors(0).majors;
    _major = _Majors[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(127),
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: 127,
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            elevation: 0.0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black12, width: 1.5)),
                image: DecorationImage(
                    image: AssetImage("assets/images/images2/appbar.png"),
                    fit: BoxFit.fill),
              ),
            ),
            shadowColor: Colors.black,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .height,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: const BoxDecoration(
          //배경이미지
            image: DecorationImage(
                image: AssetImage("assets/images/images2/paper.png"),
                fit: BoxFit.cover)),
        child: Stack(
          alignment: Alignment.center,
          //포스트잇, 테이프 겹치게
          children: [
            Positioned(
                child: Image(
                    image: AssetImage("assets/images/images2/yellow3.png"))),
            Positioned(
                top: 205,
                child: Image(
                    image: AssetImage("assets/images/images2/tape10.png"))),
            Positioned(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 80)),
                  Text("기본 정보를 등록해주세요!",
                      style:
                      TextStyle(fontFamily: "Nanum_Ogbice", fontSize: 35)),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Text("*구매할 경우 보이는 정보입니다.",
                      style:
                      TextStyle(fontFamily: "Nanum_Ogbice", fontSize: 20)),
                  Padding(padding: EdgeInsets.only(top: 80)),
                ],
              ),
            ),
            Positioned(
                left: 90,
                top: 225, //
                child: Wrap(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: [
                          Text("성별:",
                              style: TextStyle(
                                  fontFamily: "Nanum_Ogbice", fontSize: 23)),
                          Padding(padding: EdgeInsets.only(left: 18)),
                          DropdownButton<String>(
                              value: _gender,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 20,
                              style: TextStyle(
                                  fontFamily: "Nanum_Ogbice",
                                  fontSize: 18,
                                  color: Colors.black),
                              alignment: Alignment.center,
                              underline: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                              items: Gender.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value, child: Text(value));
                                  }).toList(),
                              onChanged: (String? newVal) {
                                setState(() {
                                  _gender = newVal!;
                                });
                              })
                        ],
                      ),
                    ),
                    Container(
                        child: Row(children: [
                          Text("학과:",
                              style: TextStyle(
                                  fontFamily: "Nanum_Ogbice", fontSize: 22)),
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Container(
                            width: 153,
                            child: DropdownButton<Item>(
                              value: _college,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 20,
                              underline: Container(
                                  height: 1, color: Colors.black),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Nanum_Ogbice",
                                  color: Colors.black),
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
                      width: 201,
                      padding: EdgeInsets.only(left: 47),
                      child: DropdownButton<Item>(
                        value: _major,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 20,
                        underline: Container(height: 1, color: Colors.black),
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Nanum_Ogbice",
                            color: Colors.black),
                        items: _Majors,
                        onChanged: (newVal) {
                          setState(() {
                            _major = newVal;
                          });
                        },
                      ),
                    ),
                    Container(
                      child: Row(
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text("키:",
                              style: TextStyle(
                                  fontFamily: "Nanum_Ogbice", fontSize: 23)),
                          Padding(padding: EdgeInsets.only(left: 29)),
                          SizedBox(
                              width: 70,
                              height: 21,
                              child: myFormField(
                                key: ValueKey(1),
                                onSaved: (value) {
                                  setState(() {
                                    _height = value;
                                  });
                                },
                                hintText: ("입력하기"),
                              )),
                          Text(" cm",
                              style: TextStyle(
                                  fontFamily: "Nanum_Ogbice", fontSize: 20)),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 3),
                      child: Row(
                        children: [
                          Text("SNS:",
                              style: TextStyle(
                                  fontFamily: "Nanum_Ogbice", fontSize: 23)),
                          Padding(padding: EdgeInsets.only(left: 11)),
                          //연락처 종류 선택
                          /* DropdownButton<ListTile>(
                              items: _Contacts,
                              onChanged: (value) {
                                setState(() {});
                              }),*/
                          SizedBox(
                              width: 154,
                              height: 18,
                              child: myFormField(
                                key: ValueKey(1),
                                onSaved: (value) {
                                  setState(() {
                                    _contact = value;
                                  });
                                },
                                hintText: ("입력하기"),
                              )),
                        ],
                      ),
                    ),
                  ],
                )),
            Positioned(
                top: 500,
                child: Stack(
                  children: [
                    Container(
                      width: 144,
                      height: 62,
                      child: IconButton(
                          onPressed: () {
                            print("등록완료"); //구현중....
                          },
                          icon: Image.asset(
                            "assets/images/images2/submit3x.png",
                            fit: BoxFit.fill,)),
                    ),
                    Positioned(
                        left:52,
                        bottom: 16,
                        child: Text("완료", style: TextStyle(
                            fontFamily: "Nanum_Ogbice", fontSize: 28)))
 ],
                ))
          ],
        ),
      ),
    );
  }
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
      style: TextStyle(
          fontSize: 19, fontFamily: "Nanum_Ogbice", color: Colors.black),
      decoration: InputDecoration(
          enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black))),
    );
  }
}
