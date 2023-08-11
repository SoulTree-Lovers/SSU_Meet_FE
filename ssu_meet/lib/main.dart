import 'package:flutter/material.dart';

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
      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // Try running your application with "flutter run". You'll see the
      //   // application has a blue toolbar. Then, without quitting the app, try
      //   // changing the primarySwatch below to Colors.green and then invoke
      //   // "hot reload" (press "r" in the console where you ran "flutter run",
      //   // or simply save your changes to "hot reload" in a Flutter IDE).
      //   // Notice that the counter didn't reset back to zero; the application
      //   // is not restarted.
      //   fontFamily: "Ongeul",
      //   primaryColor: const Color.fromARGB(255, 182, 222, 255),
      // ),
      // home: InitialPage(),

      home: ResponsiveWebLayout(
        pageIndex: 1,
        // 0: 사용 설명서
        // 1: 메인 화면
        // 2: 마이 페이지
      ),

      // home: InfiniteScrollDemo(),

      //home: LoginPage(),
      // home: InputProfile(),
      // home: InputPostIt(),
      // home: PurchasedPostItPage(),
    );
  }
}
