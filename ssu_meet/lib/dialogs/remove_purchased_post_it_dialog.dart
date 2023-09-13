import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ssu_meet/pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:ssu_meet/pages/purchased_post_it_page.dart';
import 'package:ssu_meet/pages/responsive_page.dart';

// 구매한 포스트잇 삭제 api
Future<dynamic> deletePurchasedSticky(int stickyId) async {
  // print("stickyId: $stickyId");
  var accessToken = await storage.read(key: "access_token");

  if(accessToken == null){
    return "GoToLoginPage";
  }

  final response = await http.delete(
    Uri.parse('http://43.202.77.44:8080/v1/members/mypage/buy-list/$stickyId'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    },
  );

  final responseData = jsonDecode(utf8.decode(response.bodyBytes));
  final isSuccess = responseData["status"];
  final message = responseData["message"];

  if (response.statusCode == 200) {
    if (isSuccess == "SUCCESS") {
      return "CompletedToRemove"; // 삭제 성공
    } else if(message == "FailedToRemove"){
      return "FailToRemove"; // 삭제 실패
    }
    else{
      return "GoToLoginPage";
    }
  } else if(response.statusCode == 401){
    // 엑세스 토큰이 만료되었거나, 유효하지 않은 경우
    if (message == "Token has expired") {
      // 엑세스 토큰이 만료된 경우
      final isSuccessNewToken =
      await getNewAccessToken(); // 리프레시 토큰으로 엑세스 토큰 재발급
      if (isSuccessNewToken == "NewAccessToken") {
        // 엑세스 토큰을 정상적으로 재발급 받은 경우 -> 그대로 작업 완료
        return "CompletedToRemove";
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
  }
  else {
    print('Failed to delete data. Error: ${response.statusCode}');
    return "GoToLoginPage";
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
              onPressed: () async {
                // DELETE api 요청 함수
                final result = await deletePurchasedSticky(stickyId);
                if(result == "CompletedToRemove"){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ResponsiveWebLayout(
                            pageIndex: 2,
                            // 0: 사용 설명서
                            // 1: 메인 화면
                            // 2: 마이 페이지
                          ),
                    ),
                  );

                }
                else {
                  Navigator.pop(context);
                }

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
