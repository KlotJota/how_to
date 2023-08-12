import 'package:flutter/material.dart';

class MyAppBarProfile extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBarProfile({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    void _openDrawer(BuildContext context) {
      Scaffold.of(context)
          .openEndDrawer(); // Mude para openEndDrawer() para abrir o endDrawer
    }

    return AppBar(
      elevation: 0.0,
      title: const Text('HowTo',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )),
      centerTitle: false,
      toolbarHeight: 50,
      actions: [
        // Use o IconTheme para definir a cor do ícone do Drawer nesta página
        IconTheme(
          data: const IconThemeData(), // Altere a cor para a desejada
          child: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _openDrawer(context),
          ),
        ),
      ],
    );
  }
}
