import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
