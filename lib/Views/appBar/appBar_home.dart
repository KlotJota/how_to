import 'package:flutter/material.dart';

class MyAppBarHome extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      title: Text('HowTo',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
      centerTitle: false,
      toolbarHeight: 50,
      backgroundColor: Color.fromARGB(255, 250, 247, 247),
    );
  }
}
