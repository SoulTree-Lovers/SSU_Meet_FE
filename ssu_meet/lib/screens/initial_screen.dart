import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "슈밋",
          style: TextStyle(
            fontFamily: "Ongeul",
            fontSize: 33,
          ),
        ),
      ),
      body: Column(
        children: const [
          Text(
            "Hello SSU Meet !",
            style: TextStyle(
              fontFamily: "Ongeul",
              color: Colors.black,
              fontSize: 40,
            ),
          ),
        ],
      ),
    );
  }
}
