import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/paper_background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: screenWidth * 0.8,
                  child: const Text(
                    "서비스 소개",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'Nanum_Ogbice',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: screenWidth * 0.8,
                  height: 21,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        "assets/images/info_images/arrow_right.png",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "포스트잇을 골라",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Nanum_Ogbice',
                            ),
                          ),
                          const Text(
                            "이상형을 찾아보세요 !",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Nanum_Ogbice',
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.3,
                            height: screenWidth * 0.3,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/info_images/blush.png",
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: screenWidth * 0.5,
                        height: screenWidth * 0.5,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/images/info_images/포스트잇.png",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  "09.27 ~ 09.30",
                  style: TextStyle(
                    fontFamily: "Nanum_Ogbice",
                    fontSize: 17,
                  ),
                ),
                const Text(
                  "축제 기간 동안 포스트잇 등록/선택 시",
                  style: TextStyle(
                    fontFamily: "Nanum_Ogbice",
                    fontSize: 17,
                  ),
                ),
                const Text(
                  "코인 3개 무료 제공 !",
                  style: TextStyle(
                    fontFamily: "Nanum_Ogbice",
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenWidth * 0.7,
                  height: screenWidth * 0.4,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/info_images/festival.png",
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: screenWidth * 0.8,
                  child: const Text(
                    "사용 설명서",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'Nanum_Ogbice',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: screenWidth * 0.8,
                  height: 21,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        "assets/images/info_images/arrow_right.png",
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "포스트잇 등록 시 ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Nanum_Ogbice',
                          ),
                        ),
                        const Text(
                          "1코인 지급 (최대 3코인)",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Nanum_Ogbice',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "* 등록된 포스트잇은 삭제가 불가능합니다.",
                          style: TextStyle(
                            color: Color(0xFFFF0000),
                            fontSize: 11,
                            fontFamily: 'Nanum_Ogbice',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: screenWidth * 0.3,
                          height: screenWidth * 0.3,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                "assets/images/info_images/hands_up_man.png",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: screenWidth * 0.4,
                      height: screenWidth * 0.7,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/images/info_images/코인지급.png",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth * 0.4,
                      height: screenWidth * 0.7,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/images/info_images/메인.png",
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const Text(
                          "마음에 드는 이성을 골라보세요 !",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Nanum_Ogbice',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: screenWidth * 0.2,
                          height: screenWidth * 0.2,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                "assets/images/info_images/lovestruck.png",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "포스트잇 앞면 내용을 확인하고",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Nanum_Ogbice',
                          ),
                        ),
                        const Text(
                          "마음에 드는 포스트잇을",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Nanum_Ogbice',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "구매하세요.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Nanum_Ogbice',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: screenWidth * 0.25,
                          height: screenWidth * 0.25,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                "assets/images/info_images/phone_in_hand.png",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: screenWidth * 0.4,
                      height: screenWidth * 0.7,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/images/info_images/코인지급.png",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth * 0.4,
                      height: screenWidth * 0.7,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/images/info_images/구입한포스트잇.png",
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const Text(
                          "마이페이지 -> 구매한 포스트잇",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Nanum_Ogbice',
                          ),
                        ),
                        const Text(
                          "연락처를 확인하세요",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Nanum_Ogbice',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: screenWidth * 0.25,
                          height: screenWidth * 0.25,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                "assets/images/info_images/smartphone_man.png",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenWidth * 0.8,
                  height: screenWidth * 0.6,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/info_images/유의사항.png",
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
