import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Image(
        image: AssetImage('images/how-to-branco.png'),
      ),
      titleSpacing: 155,
      centerTitle: true,
      toolbarHeight: 50,
      backgroundColor: Color.fromRGBO(0, 9, 89, 1),
    );
  }
}
