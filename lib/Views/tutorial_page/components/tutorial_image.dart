import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TutorialImage extends StatefulWidget {
  final String id;
  const TutorialImage(this.id, {super.key});

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
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : OrientationBuilder(builder: (context, orientation) {
            final isPortrait = orientation == Orientation.portrait;
            final containerHeight = isPortrait
                ? MediaQuery.of(context).size.height * 0.25
                : MediaQuery.of(context).size.height * 0.5;
            return Container(
                margin: const EdgeInsets.all(10),
                height: containerHeight,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Image.network(
                        tutorial!['imagem'],
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ));
          });
  }
}
