import 'package:flutter/material.dart';

class MyAppBarProfile extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    void _openDrawer(BuildContext context) {
      Scaffold.of(context)
          .openEndDrawer(); // Mude para openEndDrawer() para abrir o endDrawer
    }

    return AppBar(
      elevation: 0.5,
      title: Text('HowTo',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
      centerTitle: false,
      toolbarHeight: 50,
      backgroundColor: Color.fromARGB(255, 250, 247, 247),
      actions: [
        // Use o IconTheme para definir a cor do ícone do Drawer nesta página
        IconTheme(
          data: IconThemeData(
              color: const Color.fromARGB(
                  255, 0, 0, 0)), // Altere a cor para a desejada
          child: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _openDrawer(context),
          ),
        ),
      ],
    );
  }
}