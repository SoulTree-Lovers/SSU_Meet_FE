import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
