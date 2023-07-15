import 'package:flutter/material.dart';
import 'package:ssu_meet/pages/home_page.dart';
import 'package:ssu_meet/pages/login_page.dart';
import 'package:ssu_meet/widgets/desktop_layout.dart';

class ResponsiveWebLayout extends StatelessWidget {
  const ResponsiveWebLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            // Layout for iPhone-sized screens
            return const LoginPage();
          } else {
            // Layout for computer screens
            return const DesktopLayout();
          }
        },
      ),
    );
  }
}
