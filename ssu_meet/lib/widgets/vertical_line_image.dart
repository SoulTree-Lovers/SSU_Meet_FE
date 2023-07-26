import 'package:flutter/material.dart';

Container VerticalLineImage() {
  return Container(
    width: 20,
    height: 20,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          "assets/images/vertical_line.png",
        ),
      ),
    ),
  );
}
