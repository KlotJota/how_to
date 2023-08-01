import 'package:flutter/material.dart';

class MyAppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBarHome({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      title: const Text('HowTo',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
      centerTitle: false,
      toolbarHeight: 50,
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: const Color.fromARGB(255, 250, 247, 247),
    );
  }
}
