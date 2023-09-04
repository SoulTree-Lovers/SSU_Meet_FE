import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssu_meet/widgets/purchased_page_post_it.dart';
import 'package:http/http.dart' as http;

class PurchasedPostItPage extends StatefulWidget {
  const PurchasedPostItPage({super.key});

  @override
  State<PurchasedPostItPage> createState() => _PurchasedPostItPageState();
}

class _PurchasedPostItPageState extends State<PurchasedPostItPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
        shadowColor: const Color.fromRGBO(158, 156, 156, 1),
        flexibleSpace: const Padding(
          padding: EdgeInsets.all(15.0),
        ),
      ),
      body: PurchasedPostItBody(screenHeight, screenWidth),
    );
  }

  Container PurchasedPostItBody(double screenHeight, double screenWidth) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/images/paper_background.png',
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Container(
                    width: 15,
                    height: 15,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/images/chevron_down.png",
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "구입한 포스트잇",
                    style: TextStyle(
                      color: Color(0xFF707070),
                      fontFamily: "NanumSquareAc",
                      fontSize: 15,
                      letterSpacing: 0.30,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: getPurchasedPostItData(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the future is not yet completed
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // If an error occurred
                  return Text('Error: ${snapshot.error}');
                } else {
                  // If the future completed successfully
                  return PurchasedPagePostIt(
                    screenHeight,
                    snapshot,
                    screenWidth,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<List> getPurchasedPostItData() async {
  // 서버에서 포스트잇 데이터 가져오기
  String jsonString =
      await rootBundle.loadString('json/test_purchased_post_it_json.json');
  final jsonResponse = json.decode(jsonString);

  return jsonResponse["data"]["stickyData"];
}

// 구입한 포스트잇 데이터 가져오기 api
Future<dynamic> getPurchasedPostItData2() async {
  // print("함수가 실행은 됐습니다.");
  var url = 'http://localhost:8080/v1/members/mypage/buy-list';
  // print('Sending JSON payload: ${json.encode(data.toJson())}');
  final response = await http.get(
    Uri.parse(url),
    headers: {"Authorization": "-----"},
  );

  print("데이터 전송");

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    final message = responseData["message"];

    print(responseData);
    if (message == "ExistPostIt") {
      // 포스트잇 데이터 가져오기 성공한 경우
      print("포스트잇 데이터 가져오기 성공");
      return responseData["data"]["stickyData"];
    } else {
      print("구입한 포스트잇이 없습니다.");
      return [];
    }
    // print('Received response: $result');
  } else {
    print('Failed to send data. Error: ${response.statusCode}');
    return 0; // (네트워크 에러)
  }
}
