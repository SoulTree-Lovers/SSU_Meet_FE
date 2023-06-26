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
    return const Center(
      child: Text(
        'This is the mobile layout',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
