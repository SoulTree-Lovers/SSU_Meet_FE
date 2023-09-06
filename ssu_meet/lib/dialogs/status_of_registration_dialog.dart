import 'package:flutter/material.dart';
import 'package:ssu_meet/pages/responsive_page.dart';

void showStatusOfRegistration(BuildContext context, final isExceed) {
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
        child: (isExceed == 0)
            ? const Text(
                '포스트잇 등록을 마쳤습니다!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'NanumSquareRoundBold',
                  // fontWeight: FontWeight.w700,
                  // height: 1.31,
                ),
              )
            : const Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 2,
                children: [
                  Text(
                    '포스트잇 등록 최대 개수가 초과되었습니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'NanumSquareRoundBold',
                      // fontWeight: FontWeight.w700,
                      // height: 1.31,
                    ),
                  ),
                  Text(
                    '포스트잇이 판매되면 추가 등록이 가능합니다.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'NanumSquareRoundBold',
                      // fontWeight: FontWeight.w700,
                      // height: 1.31,
                    ),
                  ),
                  Text(
                    '(최대 등록 개수는 3개)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'NanumSquareRoundBold',
                      // fontWeight: FontWeight.w700,
                      // height: 1.31,
                    ),
                  ),
                ],
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
