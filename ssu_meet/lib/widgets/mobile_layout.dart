import 'package:flutter/material.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({
    super.key,
  });

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  @override
  Widget build(BuildContext context) {
    int coinNumber = 3; // 테스트용
    int postitNumber = 15; // 테스트용
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "나만의 슝슝이를 찾아보자 !",
            style: TextStyle(
              fontFamily: "Ongeul",
              fontSize: 30,
            ),
          ),
          backgroundColor: Colors.blue[100],
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "보유 코인: $coinNumber",
                      style: const TextStyle(
                        fontFamily: "Nanum_1",
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "포스트잇",
                          style: TextStyle(
                            fontFamily: "Ongeul",
                            fontSize: 50,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "등록 개수: $postitNumber",
                          style: const TextStyle(
                            fontFamily: "Nanum_1",
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        print("등록버튼터치");
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(45),
                        ),
                        child: const Text(
                          "+ 등록",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: screenWidth * 0.95,
                  height: 1,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.7,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 100,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                    childAspectRatio: 1 / 1, //item 의 가로 1, 세로 1 의 비율
                    mainAxisSpacing: 10, //수평 Padding
                    crossAxisSpacing: 10, //수직 Padding
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    // return Text(index.toString());
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                        ),
                        child: Text("$index"),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
