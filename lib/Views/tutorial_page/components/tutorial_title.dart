import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TutorialTitle extends StatefulWidget {
  final String id;
  const TutorialTitle(this.id, {super.key});

  @override
  State<TutorialTitle> createState() => _TutorialTitleState();
}

class _TutorialTitleState extends State<TutorialTitle> {
  DocumentSnapshot<Object?>? tutorial;

  @override
  void initState() {
    super.initState();
    buscarTutorial(widget.id);
  }

  void buscarTutorial(String id) async {
    final tutorialDoc =
        await FirebaseFirestore.instance.collection('tutoriais').doc(id).get();
    setState(() {
      tutorial = tutorialDoc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return tutorial == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            alignment: Alignment.center,
            height: 45,
            color: Color.fromARGB(157, 230, 230, 230),
            child: Text(
              tutorial!['titulo'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
