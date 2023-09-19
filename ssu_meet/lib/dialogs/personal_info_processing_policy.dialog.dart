import 'package:flutter/material.dart';

void showPersonalInfoProcessingPolicy(
    BuildContext context, double screenWidth) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      contentTextStyle: TextStyle(
        fontFamily: "NanumSquareAc",
        fontSize: screenWidth * 0.03,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        width: screenWidth * 1.1,
        height: screenWidth * 1.3,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              blurRadius: 15,
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            image: AssetImage(
              "assets/images/images2/paper.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "\n개인정보 처리방침 안내",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "NanumSquareAc",
                fontSize: screenWidth * 0.045,
                color: Colors.black,
              ),
            ),
            Center(
              child: SizedBox(
                width: screenWidth * 0.7,
                child: const Divider(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  thickness: 1.0,
                ),
              ),
            ),
           SizedBox(
             width: screenWidth * 0.7,
             child: const Center(
                child:  Text(
                  "‘슈밋’은 서비스 제공을 위하여 아래와 같이 개인정보를 수집‧"
                  "이용 및 제공하고자 합니다. 내용을 읽으신 후 동의 여부를 결정하여 주십시오.",
                ),
              ),
           ),
            const Text(
              "□ 개인정보 수집‧이용 내역 (필수사항)                     \n\n"
              "• 항목\n"
              "  성별, 학번, 학과, 학부, 생년월일, 연락처\n\n"
              "• 수집 목적\n"
              " 슈밋 서비스 회원 정보 등록 및 서비스 이용\n\n"
              "• 보유 기간\n"
              " 서비스 종료 후 즉시 파기",
            ),
            Center(
              child: SizedBox(
                width: screenWidth * 0.7,
                child: const Divider(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  thickness: 1.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              width: screenWidth * 0.7,
              height: screenWidth * 0.12,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(217, 217, 217, 0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  "※ 위의 개인정보 수집‧이용에 대한 동의를 거부할 수 있습니다.\n"
                  "단, 동의를 거부할 경우 원활한 서비스 제공에 일부 제한을 받을 수 있습니다.\n"
                      "※ 유세인트(U-saint) 비밀번호는 수집하지 않습니다.",
                  style: TextStyle(
                    fontFamily: "NanumSquareAc",
                    fontSize: screenWidth * 0.02,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.white,
                  shadowColor: const Color.fromRGBO(0, 0, 0, 0.5),
                  elevation: 10,
                  side: const BorderSide(
                    color: Colors.black,
                  ),
                  fixedSize: const Size(70, 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
              child: Text(
                "확인",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "NanumSquareAc",
                  fontSize: screenWidth * 0.03,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
