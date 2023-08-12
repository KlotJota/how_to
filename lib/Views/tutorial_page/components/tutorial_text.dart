import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TutorialText extends StatefulWidget {
  final String id;
  const TutorialText(this.id, {super.key});

  @override
  State<TutorialText> createState() => _TutorialTextState();
}

class _TutorialTextState extends State<TutorialText> {
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
        : Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 1,
                width: MediaQuery.of(context).size.width - 20,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.topCenter,
                child: const Text(
                  'How To?',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Container(
                  child: Text(tutorial!['texto'],
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 15,
                      )),
                ),
              ),
            ],
          );
  }
}
