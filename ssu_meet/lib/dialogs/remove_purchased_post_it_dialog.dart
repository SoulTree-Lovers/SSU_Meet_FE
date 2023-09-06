import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ssu_meet/pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:ssu_meet/pages/responsive_page.dart';

// 구매한 포스트잇 삭제 api
Future<int> deletePurchasedSticky(int stickyId) async {
  // print("stickyId: $stickyId");
  var token = await storage.read(key: "token");

  final response = await http.delete(
    Uri.parse('http://localhost:8080/v1/members/mypage/buy-list/$stickyId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    final responseData = jsonDecode(utf8.decode(response.bodyBytes));

    if (responseData["status"] == "SUCCESS") {
      print(responseData["message"]);
      return 0; // 삭제 성공
    } else {
      print(responseData["message"]);
      return 1; // 삭제 실패
    }
  } else {
    print('Failed to delete data. Error: ${response.statusCode}');
    return 2;
  }
}

void removePurchasedPostIt(BuildContext context, int stickyId) {
  showDialog(
    barrierColor: Colors.white.withOpacity(0.7),
    context: context,
    builder: (BuildContext context) => AlertDialog(
      contentPadding:
          const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
      actionsPadding: const EdgeInsets.only(bottom: 25),
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          width: 1.5,
          strokeAlign: BorderSide.strokeAlignOutside,
          color: Color(0xFF020202),
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      shadowColor: const Color(0x3F000000),
      content: Container(
        width: 300,
        height: 55,
        alignment: Alignment.center,
        child: const Text(
          '정말 삭제하시겠습니까?',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontFamily: 'NanumSquareRoundBold',
            // fontWeight: FontWeight.w700,
            // height: 1.31,
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /* GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 70,
                height: 25,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: const Center(
                  child: Text(
                    "취소",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'NanumSquareRoundR',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                // DELETE api 요청 함수
                deletePurchasedSticky(stickyId).then((result) {
                  // 삭제 완료
                  if(result == 0){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                });
                },
              child: Container(
                width: 70,
                height: 25,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black,
                ),
                child: const Center(
                  child: Text(
                    "삭제",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'NanumSquareRoundR',
                    ),
                  ),
                ),
              ),
            ), */
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shadowColor: Colors.black26,
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                  fixedSize: const Size(70, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
              child: const Text(
                "취소",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "NanumSquareRoundR",
                  fontSize: 10,
                  //fontWeight: FontWeight.w500
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {
                // DELETE api 요청 함수
                deletePurchasedSticky(stickyId).then((result) {
                  // 삭제 완료
                  if (result == 0) {
                    // 마이페이지로 이동
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ResponsiveWebLayout(
                          pageIndex: 2,
                        ),
                      ),
                    );
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shadowColor: Colors.black26,
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                  fixedSize: const Size(70, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
              child: const Text(
                "삭제",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "NanumSquareRoundR",
                  fontSize: 10,
                  //fontWeight: FontWeight.w500
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
