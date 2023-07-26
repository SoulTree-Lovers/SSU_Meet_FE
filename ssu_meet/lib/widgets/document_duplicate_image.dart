import 'package:flutter/material.dart';

Container DocumentDuplicateImage(double screenWidth) {
  return Container(
    width: screenWidth * 0.03,
    height: screenWidth * 0.03,
    decoration: const BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage(
          "assets/images/document_duplicate.png",
        ),
      ),
    ),
  );
}
