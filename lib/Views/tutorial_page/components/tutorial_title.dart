import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TutorialTitle extends StatefulWidget {
  final String id;
  TutorialTitle(this.id);

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
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.topCenter,
            child: Text(
              tutorial!['titulo'],
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
