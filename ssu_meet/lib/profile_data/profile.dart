import 'package:flutter/material.dart';
import 'majors.dart';
class PersonDefaultProfile {
  List<DropdownMenuItem<Item>> colleges = List.empty(growable: true);
  List<DropdownMenuItem<Item>> majors = List.empty(growable: true);
  List<String> genders = ['선택하기', '남', '여'];
  String? _gender;
  int? _age;
  Item? _college;
  Item? _major;
  int? _height;
  String? _contact;

  PersonDefaultProfile(){
    _gender = genders[0];
    colleges = Colleges().colleges;
    _college = colleges[0].value;
    majors = Majors(0).majors;
    _major = majors[0].value;
  }
}