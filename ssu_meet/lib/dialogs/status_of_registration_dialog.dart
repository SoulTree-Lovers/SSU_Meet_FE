import 'package:flutter/material.dart';
import 'package:ssu_meet/pages/responsive_page.dart';

void showStatusOfRegistration(BuildContext context, final result) {
  double screenWidth = MediaQuery.of(context).size.width;
  showDialog(
    barrierColor: Colors.white.withOpacity(0.7),
    context: context,
    builder: (BuildContext context) => AlertDialog(
      contentPadding:
           EdgeInsets.only(top: 25, left: screenWidth * 0.01, right: screenWidth * 0.01, bottom: 10),
      actionsPadding:  EdgeInsets.only(bottom: screenWidth * 0.02),
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
      content: SizedBox(
        width: screenWidth * 0.9,
        height: screenWidth * 0.2,
        child: (result != "StickyExceeded")
            ?  Center(
              child: Text(
                  '포스트잇 등록을 마쳤습니다!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.037,
                    fontFamily: 'NanumSquareRoundBold',
                    // fontWeight: FontWeight.w700,
                    // height: 1.31,
                  ),
                ),
            )
            : Center(
          child:Text(
                    '포스트잇 등록 최대 개수가 초과되었습니다.\n포스트잇이 판매되면 추가 등록이 가능합니다.\n(최대 등록 개수는 3개)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.037,
                      fontFamily: 'NanumSquareRoundBold',
                    ),
                  ),

              ),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ResponsiveWebLayout(pageIndex: 1),
                ),
              );
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
