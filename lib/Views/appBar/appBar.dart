import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Image(
        image: AssetImage('images/how-to-branco.png'),
      ),
      titleSpacing: 155,
      centerTitle: true,
      toolbarHeight: 50,
      backgroundColor: const Color.fromRGBO(0, 9, 89, 1),
    );
  }
}
