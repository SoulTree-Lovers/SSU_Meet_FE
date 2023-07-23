import 'package:flutter/material.dart';

Container DocumentDuplicateImage() {
  return Container(
    width: 20,
    height: 20,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          "assets/images/document_duplicate.png",
        ),
      ),
    ),
  );
}
