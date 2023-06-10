import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TutorialImage extends StatefulWidget {
  final String id;
  TutorialImage(this.id);

  @override
  State<TutorialImage> createState() => _TutorialImageState();
}

class _TutorialImageState extends State<TutorialImage> {
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
            height: 200,
            child: Column(
              children: [
                Expanded(
                    child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Image.network(
                        tutorial!['imagem'],
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                )),
              ],
            ),
          );
  }
}
