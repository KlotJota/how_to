import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/tutorial_page/tutorial-page.dart';

class TutorialText extends StatefulWidget {
  final String id;
  TutorialText(this.id);

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
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                color: Colors.black,
                height: 1,
                width: MediaQuery.of(context).size.width - 20,
              ),
              Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.topCenter,
                child: Text(
                  'How To?',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Container(
                  child: Text(tutorial!['texto'],
                      style: TextStyle(
                        fontSize: 15,
                      )),
                ),
              ),
            ],
          );
  }
}