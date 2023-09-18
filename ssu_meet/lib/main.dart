import 'package:flutter/material.dart';
import 'package:ssu_meet/pages/login_page.dart';
import 'package:ssu_meet/pages/responsive_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SSU_MEET',
      home: ResponsiveWebLayout(
        pageIndex: 1,
        // 0: 사용 설명서
        // 1: 메인 화면
        // 2: 마이 페이지
      ),
    );
  }
}
