import 'package:flutter/material.dart';

class MyAppBarHome extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      title: Text('HowTo',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
      centerTitle: false,
      toolbarHeight: 60,
      backgroundColor: Color.fromARGB(255, 250, 247, 247),
    );
  }
}
