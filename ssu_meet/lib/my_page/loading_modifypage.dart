import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../profile_data/profile.dart';
import 'modify_information.dart';

class LoadingModifyPage {
  void getOldProfile(BuildContext context) async {
    var jsonString = await rootBundle.loadString('json/old_profile.json');
    var data = MyData.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ModifyPage(
                    initData: data
                ))
    );
  }
}

