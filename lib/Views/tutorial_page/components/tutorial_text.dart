import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/tutorial_page/components/text_to_speech.dart';
import 'package:how_to/Views/face_detector/face_detector_page.dart';
import 'package:get/get.dart';

class TutorialText extends StatefulWidget {
  final String id;
  const TutorialText(this.id, {super.key});

  @override
  State<TutorialText> createState() => _TutorialTextState();
}

class _TutorialTextState extends State<TutorialText> {
  DocumentSnapshot<Object?>? tutorial;

  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;

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

  void popupNarrador() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 10,
            titlePadding: const EdgeInsets.all(5),
            title: const Text('Narrador'),
            backgroundColor: const Color.fromARGB(255, 250, 247, 247),
            content: const Text(
                'Com essa opção, você pode ouvir o conteúdo do tutorial'),
            actions: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 9, 89, 1),
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.only(top: 5),
                  height: 30,
                  width: 80,
                  child: const Text(
                    'Entendi!',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          );
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
                margin: const EdgeInsets.only(top: 30, bottom: 20),
                alignment: Alignment.topCenter,
                child: const Text(
                  'How To?',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       margin: EdgeInsets.only(bottom: 10, left: 5),
              //       decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: const Color.fromRGBO(0, 9, 89, 1)),
              //       child: GestureDetector(
              //         onTap: () {
              //           popupNarrador();
              //         },
              //         child: Icon(
              //           Icons.question_mark,
              //           color: Colors.white,
              //           size: 15,
              //         ),
              //       ),
              //     ),
              //   ],
              // ), popup que da instruções sobre o text_to_speech
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Container(
                  child: Text(tutorial!['texto'],
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: isAccessibilityEnabled ? 20 : 16,
                      )),
                ),
              ),
            ],
          );
  }
}
