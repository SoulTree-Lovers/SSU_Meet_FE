import 'package:flutter/material.dart';

class PostItSample extends StatelessWidget {
  var nickname;
  var age;
  var mbti;
  var hobby;
  int index;

  PostItSample({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: const BoxDecoration(
        color: Colors.amber,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$index",
              style: const TextStyle(
                fontFamily: "Nanum_Ogbice",
                fontSize: 20,
              ),
            ),
            const Text(
              "닉네임: ",
              style: TextStyle(
                fontFamily: "Nanum_Ogbice",
                fontSize: 20,
              ),
            ),
            const Text(
              "나이: ",
              style: TextStyle(
                fontFamily: "Nanum_Ogbice",
                fontSize: 20,
              ),
            ),
            const Text(
              "MBTI: ",
              style: TextStyle(
                fontFamily: "Nanum_Ogbice",
                fontSize: 20,
              ),
            ),
            const Text(
              "취미: ",
              style: TextStyle(
                fontFamily: "Nanum_Ogbice",
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
