import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ssu_meet/widgets/main_page_post_it.dart';

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
                  return MainPagePostIt(
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
  // 서버에서 포스트잇 앞면 데이터 가져오기
  String jsonString =
      await rootBundle.loadString('json/purchased_post_it_json.json');
  final jsonResponse = json.decode(jsonString);

  return jsonResponse;
}
