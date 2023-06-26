import 'package:flutter/material.dart';
import 'package:ssu_meet/widgets/desktop_layout.dart';
import 'package:ssu_meet/widgets/mobile_layout.dart';

class ResponsiveWebLayout extends StatelessWidget {
  const ResponsiveWebLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Web'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth <= 600) {
            // Layout for iPhone-sized screens
            return const MobileLayout();
          } else {
            // Layout for computer screens
            return const DesktopLayout();
          }
        },
      ),
    );
  }
}
