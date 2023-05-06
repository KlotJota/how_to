import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:how_to/Views/home.dart';
import 'package:how_to/Views/references.dart';
import 'package:how_to/Views/search-page.dart';
import 'package:how_to/Views/tutorial-page.dart';
import 'package:how_to/Views/user-profile.dart';
import 'package:get/get.dart';

class TutorialContentPage extends StatefulWidget {
  const TutorialContentPage({super.key});

  @override
  State<TutorialContentPage> createState() => TutorialContentState();
}

class TutorialContentState extends State<TutorialContentPage> {
  int paginaAtual = 0;
  late PageController pc;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          TutorialPage(),
          References(),
        ],
        onPageChanged: setPaginaAtual,
      ),
    );
  }
}
