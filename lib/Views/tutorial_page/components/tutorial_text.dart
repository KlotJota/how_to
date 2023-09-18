import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/tutorial_page/components/text_to_speech.dart';
import 'package:get/get.dart';

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
                'Com essa opção, você pode ouvir o conteúdo em texto contido no tutorial'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextToSpeech(),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromRGBO(0, 9, 89, 1)),
                    child: GestureDetector(
                      onTap: () {
                        popupNarrador();
                      },
                      child: Icon(
                        Icons.question_mark,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  )
                ],
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
