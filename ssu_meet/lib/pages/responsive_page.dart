import 'package:flutter/material.dart';
import 'package:ssu_meet/pages/info_page.dart';
import 'package:ssu_meet/pages/my_page.dart';
import 'package:ssu_meet/pages/test_main_page.dart';
import 'package:ssu_meet/pages/login_page.dart';

class ResponsiveWebLayout extends StatefulWidget {
  const ResponsiveWebLayout({super.key});

  @override
  State<ResponsiveWebLayout> createState() => _ResponsiveWebLayoutState();
}

class _ResponsiveWebLayoutState extends State<ResponsiveWebLayout> {
  int _selectedIndexScreen = 1; // Main Page

  final List _children = [
    const InfoPage(),
    const TestMainPage(),
    const MyPage(),
    const LoginPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
        shadowColor: const Color.fromRGBO(158, 156, 156, 1),
      ),
      body: _children[_selectedIndexScreen],
      // body: LayoutBuilder(
      //   builder: (BuildContext context, BoxConstraints constraints) {
      //     if (constraints.maxWidth <= 600) {
      //       // Layout for iPhone-sized screens
      //       // return const HomePage();
      //       return const TestMainPage();
      //     } else {
      //       // Layout for computer screens
      //       return const DesktopLayout();
      //     }
      //   },

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
        selectedItemColor: const Color.fromRGBO(24, 24, 27, 1),
        unselectedItemColor: const Color.fromARGB(255, 114, 113, 113),
        currentIndex: _selectedIndexScreen,
        onTap: (int index) {
          setState(() {
            _selectedIndexScreen = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                "assets/images/info_page_icon.png",
              ),
            ),
            label: "설명서",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                "assets/images/home_page_icon.png",
              ),
            ),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                "assets/images/my_page_icon.png",
              ),
            ),
            label: "마이페이지",
          ),
        ],
      ),
    );
  }
}
