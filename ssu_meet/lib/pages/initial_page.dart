import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ssu_meet/pages/responsive_page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 1),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ResponsiveWebLayout(
              pageIndex: 1,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(
            width: screenWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/splash_page_images/paper_background.png",
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenheight * 0.2,
                ),
                SizedBox(
                  width: screenWidth * 0.35,
                  height: screenWidth * 0.3,
                  child: const Image(
                    // fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/splash_page_images/heart.png",
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.3,
                  height: screenWidth * 0.15,
                  child: const Image(
                    // fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/splash_page_images/ssu_meet.png",
                    ),
                  ),
                ),
                SizedBox(
                  height: screenheight * 0.3,
                ),
                Text(
                  "ssu_meet",
                  style: TextStyle(
                    fontFamily: "Nanum_Ogbice",
                    color: Colors.black,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
