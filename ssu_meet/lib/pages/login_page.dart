import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:ssu_meet/pages/input_profile_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ssu_meet/pages/responsive_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final TextEditingController studentIdController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

const storage = FlutterSecureStorage();
/* FlutterSecureStorage 사용법
  // Import plugin 
  import 'package:flutter_secure_storage/flutter_secure_storage.dart';

  // Create storage
  final _storage = const FlutterSecureStorage();

  // Read value
  String value = await _storage.read(key: key);

  // Read all values
  Map<String, String> allValues = await _storage.readAll();

  // Delete value
  await _storage.delete(key: key);

  // Delete all
  await _storage.deleteAll();

  // Write value
  await _storage.write(key: key, value: value);
  
  */

// final TextEditingController studentIdController = TextEditingController();
// final TextEditingController passwordController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

String? _studentId = '';
String? _password = '';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double radians = 40 * math.pi / 180;

    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffEFEFEF),
        elevation: 0,
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/paper_background.png'),
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  SizedBox(
                    width: screenWidth,
                    height: screenHeight * 0.35,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: screenHeight * 0.4,
                          child: const Image(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/login_logo.png'),
                          ),
                        ),
                        Positioned.directional(
                          // right: screenWidth * 0.68,
                          bottom: screenHeight * 0.29,
                          start: screenHeight * 0.04,
                          end: screenHeight * 0.3,
                          textDirection: TextDirection.ltr,
                          child: SizedBox(
                            width: screenHeight * 0.07,
                            height: screenHeight * 0.07,
                            child: const Image(
                              fit: BoxFit.contain,
                              image: AssetImage('assets/images/heart.png'),
                            ),
                          ),
                        ),
                        Positioned.directional(
                          //left: screenWidth * 0.67,
                          bottom: screenHeight * 0.26,
                          start: screenHeight * 0.3,
                          end: screenHeight * 0.07,
                          textDirection: TextDirection.ltr,
                          child: Transform.rotate(
                            angle: radians * 0.75,
                            child: SizedBox(
                              width: screenHeight * 0.055,
                              height: screenHeight * 0.055,
                              child: const Image(
                                fit: BoxFit.contain,
                                image: AssetImage('assets/images/heart.png'),
                              ),
                            ),
                          ),
                        ),
                        Positioned.directional(
                          //left: screenWidth * 0.8,
                          bottom: screenHeight * 0.08,
                          start: screenHeight * 0.35,
                          end: screenHeight * 0.01,
                          textDirection: TextDirection.ltr,
                          child: Transform.rotate(
                            angle: radians,
                            child: SizedBox(
                              width: screenHeight * 0.06,
                              height: screenHeight * 0.06,
                              child: const Image(
                                fit: BoxFit.contain,
                                image: AssetImage('assets/images/heart.png'),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Stack(
                      children: [
                        Container(
                          width: screenWidth,
                          height: screenHeight * 0.7,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/rectangle.png'),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 55),
                            const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 22,
                                color: Color(0xffA9A8A8),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 60, right: 60),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.always,
                                onSaved: (String? newValue) {
                                  setState(() {
                                    _studentId = newValue;
                                  });
                                },
                                obscureText: false,
                                cursorColor: Colors.black,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 20),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: '학번',
                                  hintStyle: TextStyle(
                                    color: Color(0xffA9A8A8),
                                    fontSize: 14,
                                  ),
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(25, 15, 10, 15),
                                    child: Icon(Icons.person_outline_rounded),
                                  ),
                                  prefixIconColor: Color(0xffA9A8A8),
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 60, right: 60),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.always,
                                onSaved: (String? newValue) {
                                  setState(() {
                                    _password = newValue;
                                  });
                                },
                                obscureText: true,
                                cursorColor: Colors.black,
                                textInputAction: TextInputAction.done,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 20),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: '유세인트 비밀번호',
                                  hintStyle: TextStyle(
                                    color: Color(0xffA9A8A8),
                                    fontSize: 14,
                                  ),
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(25, 15, 10, 15),
                                    child: Icon(Icons.lock_outline_rounded),
                                  ),
                                  prefixIconColor: Color(0xffA9A8A8),
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            SizedBox(
                              // width: screenWidth / 6 + 15,
                              height: 40,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  side: const BorderSide(
                                    color: Color(0xff8E8E8E),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () async {
                                  _formKey.currentState!.save();
                                  bool isMetInput = true;

                                  if (_studentId == null ||
                                      _studentId == "" ||
                                      _password == null ||
                                      _password == "") {
                                    isMetInput =
                                        false; // 학과/비번 중 하나라도 입력하지 않은 경우
                                  }

                                  while (true) {
                                    if (!isMetInput) {
                                      // 입력이 충족되지 않은 경우 -> 로그인 api 보내지 않고 프론트단에서 처리.
                                      if (!mounted) return;
                                      _showIsNotMetInput(context);
                                      break;
                                    }
                                    final result = await login2();
                                    if (result == 1) {
                                      // 개인정보등록화면으로 이동
                                      // print("개인정보등록 화면으로 이동합니다.");
                                      if (!mounted) return;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const InputProfile(),
                                        ),
                                      );
                                      break;
                                    } else if (result == 2) {
                                      // 홈 화면으로 이동
                                      // print("홈 화면으로 이동합니다.");
                                      if (!mounted) return;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ResponsiveWebLayout(
                                            pageIndex: 1,
                                          ),
                                        ),
                                      );
                                      break;
                                    } else if (result == 5) {
                                      // 로그인 화면으로 이동
                                      // print("로그인 화면으로 이동합니다.");
                                      if (!mounted) return;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ),
                                      );
                                      break;
                                    } else if (result == 3 || result != 4) {
                                      if (!mounted) return;
                                      _showFailedToLoginDialog(context);
                                      break;
                                      // print("로그인 실패");
                                      // 팝업 창 띄워주기
                                    }
                                  }
                                },
                                child: Text(
                                  "로그인",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    color: Colors.white,
                                    fontFamily: "NanumSquareRoundR",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 로그인을 실패하였을 경우 팝업 창
  void _showFailedToLoginDialog(BuildContext context) {
    showDialog(
      barrierColor: Colors.white.withOpacity(0.7),
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding:
            const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
        actionsPadding: const EdgeInsets.only(bottom: 30),
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
          width: 250,
          height: 55,
          alignment: Alignment.center,
          child: const Text(
            '로그인에 실패하였습니다.',
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
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
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
                "확인",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "NanumSquareRoundR",
                  fontSize: 10,
                  //fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 학번이나 비밀번호를 입력하지 않았을 경우 팝업창
  void _showIsNotMetInput(BuildContext context) {
    print("학번/비밀번호 입력안함");
    showDialog(
      barrierColor: Colors.white.withOpacity(0.7),
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding:
            const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
        actionsPadding: const EdgeInsets.only(bottom: 30),
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
          width: 250,
          height: 55,
          alignment: Alignment.center,
          child: const Text(
            '학번 또는 비밀번호를 입력해주세요.',
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
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
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
                ),
              ),
              child: const Text(
                "확인",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "NanumSquareRoundR",
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyData {
  final String studentNumber;
  final String password;

  MyData(this.studentNumber, this.password);

  Map<String, dynamic> toJson() => {
        'studentNumber': studentNumber,
        'password': password,
      };
}

Future<int> login2() async {
  const url = 'https://ssumeet.shop/v1/members/login';
  final data = MyData(_studentId!, _password!);

  String newTokenMessage;

  var accessToken = await storage.read(key: "access_token");

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
      body: json.encode(data.toJson()),
    );

    final responseData = jsonDecode(utf8.decode(response.bodyBytes));
    final isSuccess = responseData["status"];
    final message = responseData["message"];

    if (response.statusCode == 200) {
      // 엑세스 토큰이 이미 있는 경우
      if (accessToken != null) {
        if (isSuccess == "SUCCESS") {
          // print("<Token exists>: $responseData");
          if (message == "RequiredFirstRegistration") {
            return 1;
          } else if (message == "RegisteredUser") {
            return 2;
          }
        } else if (isSuccess == "ERROR") {
          // print("로그인 정보 오류");
          return 3;
        }
      } else {
        // 엑세스 토큰이 없는 경우 -> 리프레시 + 엑세스 모두 새로 받아 저장 후 재 로그인 요청
        // print("<Token doesn't exist>: $responseData");
        await storage.write(
            key: 'refresh_token', value: responseData["data"]["refreshToken"]);
        await storage.write(
            key: 'access_token', value: responseData["data"]["accessToken"]);
        // print("로그인 api를 재 요청합니다");
        return 4;
      }
    } else if (response.statusCode == 401) {
      // print(message);
      if (message == "Token has expired") {
        // 유효하지 않은 토큰 처리
        newTokenMessage = await getNewAccessToken();

        if (newTokenMessage == "NewAccessToken") {
          // 엑세스 토큰 재발급 성공 (기존 정보로 다시 로그인 후 개인정보 등록 여부에 따라 페이지 이동)
          // print("로그인 api를 재 요청합니다");
          return 4;
        } else if (newTokenMessage == "storageDeleted") {
          // 리프레시 토큰마저 만료됨 (로그인 화면으로 이동)
          // print("로그인을 다시 합니다");
          return 5;
        } else {
          // Token Error || Network Error || Try Catch Error 인 경우
          return 6;
        }
      } else if (message == "Token error") {
        // 엑세스 토큰이 틀린 경우
        await storage.deleteAll(); // 기존 토큰 삭제
      }
      // print("로그인을 다시 합니다");
      return 5; // (로그인 화면으로 이동)
    } else {
      // print('Failed to send data. Error: ${response.statusCode}');
      return 6; // 로그인 실패 (네트워크 에러)
    }
    return 0;
  } catch (e) {
    // print("로그인 함수에서 에러 발생: $e");
    return 6;
  }
}

// 리프레시 토큰 -> 엑세스 토큰 재발급 요청 api
Future<String> getNewAccessToken() async {
  const url = 'https://ssumeet.shop/v1/members/new/accesstoken';
  var refreshToken = await storage.read(key: 'refresh_token');

  try {
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${refreshToken!}',
      'Access-Control-Allow-Origin': '*',
    });

    final responseData = jsonDecode(utf8.decode(response.bodyBytes));
    final isSuccess = responseData["status"];
    final message = responseData["message"];

    if (response.statusCode == 200) {
      // 리프레시 토큰이 유효한 경우 (정상 재발급)
      await storage.write(
          key: 'access_token', value: responseData["data"]["accessToken"]);
      return "NewAccessToken";
    } else if (response.statusCode == 401) {
      // print(message);
      await storage.deleteAll();
      if (message == "Token has expired") {
        // 리프레시 만료
        return "storageDeleted"; // 로그인 화면으로 이동
      } else {
        // 토큰 에러
        return "tokenError"; // 로그인 화면으로 이동
      }
    } else {
      // print(
      //     'Failed to get new accessToken. Error: ${response.statusCode}'); // 재발급 실패 (네트워크 에러)
      return "NetworkError";
    }
  } catch (e) {
    // print("토큰 재발급 함수에서 에러 발생: $e");
    return "TryCatchError";
  }
}
