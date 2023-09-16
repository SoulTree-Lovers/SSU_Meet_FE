import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssu_meet/pages/login_page.dart';
import 'package:ssu_meet/widgets/purchased_page_post_it.dart';
import 'package:http/http.dart' as http;

class PurchasedPostItPage extends StatefulWidget {
  const PurchasedPostItPage({super.key});

  @override
  State<PurchasedPostItPage> createState() => _PurchasedPostItPageState();
}

class _PurchasedPostItPageState extends State<PurchasedPostItPage> {
  bool isRegistered = false;

  // 구입한 포스트잇 데이터 가져오기 api
  Future<dynamic> getPurchasedPostItData() async {
    // print("함수가 실행은 됐습니다.");
    var url = 'http://43.202.77.44:8080/v1/members/mypage/buy-list';
    // print('Sending JSON payload: ${json.encode(data.toJson())}');

    // 디바이스에 저장된 access token과 refresh token 읽어오기 (존재하지 않으면 null 리턴)
    final accessToken = await storage.read(key: 'access_token');

    if (accessToken == null) {
      // 미등록 사용자
      return [];
    }

    setState(() {
      isRegistered = true; // 등록된 사용자임을 검증
    });

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    print("데이터 전송");

    final responseData = jsonDecode(utf8.decode(response.bodyBytes));
    final message = responseData["message"];

    if (response.statusCode == 200) {
      // 구입한 포스트잇 목록 가져오기 성공
      // print(responseData);
      if (message == "ExistBuyPostIt") {
        // 포스트잇 데이터 가져오기 성공한 경우
        print("포스트잇 데이터 가져오기 성공");
        return responseData["data"]["stickyData"];
      } else {
        print("Request 에러 발생");
        return [];
      }
      // print('Received response: $result');
    } else if (response.statusCode == 401) {
      // 엑세스 토큰이 만료되었거나, 유효하지 않은 경우
      if (message == "Token has expired") {
        // 엑세스 토큰이 만료된 경우
        final isSuccessNewToken =
            await getNewAccessToken(); // 리프레시 토큰으로 엑세스 토큰 재발급
        if (isSuccessNewToken == "NewAccessToken") {
          // 엑세스 토큰을 정상적으로 재발급 받은 경우
          return await getPurchasedPostItData(); // 구입한 포스트잇 요청 함수 재실행
        } else if (isSuccessNewToken == "storageDelete") {
          // 리프레시 토큰이 만료된 경우
          return "GoToLoginPage";
        } else if (isSuccessNewToken == "tokenError") {
          // 리프레시 토큰이 에러가 발생한 경우
          return "GoToLoginPage";
        } else {
          // 네트워크 에러 또는 토큰 재발급 함수 자체에 에러가 발생한 경우
          return "GoToLoginPage";
        }
      } else {
        // 엑세스 토큰이 유효하지 않은 경우 및 그 외 예외
        await storage.deleteAll(); // 저장되어 있던 토큰 모두 삭제
        return "GoToLoginPage";
      }
    } else {
      print('Failed to send data. Error: ${response.statusCode}');
      return "GoToLoginPage"; // (네트워크 에러)
    }
  }

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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.keyboard_arrow_left,
            color: Color(0xff717171),
            size: 30,
          ),
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
      child: !isRegistered
          ? const Center(
              child: Text(
                '로그인 후 이용할 수 있습니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'NanumSquareRoundBold',
                  // fontWeight: FontWeight.w700,
                  // height: 1.31,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Color(0xff717171),
                          size: 30,
                        ),
                        Text(
                          "구입한 포스트잇",
                          style: TextStyle(
                            color: Color(0xff717171),
                            fontWeight: FontWeight.w600,
                            fontFamily: "NanumSquareAc",
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: getPurchasedPostItData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // While the future is not yet completed
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        // If an error occurred
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.data == "GoToLoginPage") {
                        print("GoToLoginPage");
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                        return const Text("GoToLoginPage");
                      } else {
                        // If the future completed successfully
                        return PurchasedPagePostIt(
                          screenHeight,
                          screenWidth,
                          snapshot,
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

Future<List> getPurchasedPostItDataLocal() async {
  // 서버에서 포스트잇 데이터 가져오기
  String jsonString =
      await rootBundle.loadString('json/test_purchased_post_it_json.json');
  final jsonResponse = json.decode(jsonString);

  return jsonResponse["data"]["stickyData"];
}
