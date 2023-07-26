import 'package:flutter/material.dart';

import 'package:ssu_meet/pages/responsive_page.dart';

class ModifyPage extends StatelessWidget {
  const ModifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
        shadowColor: const Color.fromRGBO(158, 156, 156, 1),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResponsiveWebLayout()));
            },
            icon: Icon(Icons.keyboard_arrow_left,
                color: Color(0xff717171), size: 30)),
      ),
    );
  }
}
