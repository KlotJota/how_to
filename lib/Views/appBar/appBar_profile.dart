import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';

class MyAppBarProfile extends StatelessWidget implements PreferredSizeWidget {
  MyAppBarProfile({super.key});

  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;
  TtsService ttsService = TtsService();

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
          data: const IconThemeData(
            color: Color.fromRGBO(0, 9, 89, 1),
          ), // Altere a cor para a desejada
          child: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                if (isAccessibilityEnabled) {
                  ttsService.speak('Menu lateral aberto');
                }
                HapticFeedback.heavyImpact();
                _openDrawer(context);
              }),
        ),
      ],
    );
  }
}
