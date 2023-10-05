import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TextToSpeech extends StatefulWidget {
  final String id;
  const TextToSpeech(this.id, {Key? key}) : super(key: key);

  @override
  State<TextToSpeech> createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {
  final FlutterTts flutterTts = FlutterTts();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot<Object?>? tutorial;
  String? tutorialText;

  bool isReading = false;
  List<String> textToReadList = [];
  // int currentIndex = 0;
  // int pauseIndex = 0; // Armazena o índice de pausa

  @override
  void initState() {
    super.initState();
    initializeTts();
    buscarTutorial(widget.id);
    // currentIndex = 0;
  }

  @override
  void dispose() {
    flutterTts.stop(); // Pare a leitura ao sair do widget
    super.dispose();
    textToReadList = [];
  }

  Future<void> buscarTutorial(String id) async {
    final tutorialDoc =
        await FirebaseFirestore.instance.collection('tutoriais').doc(id).get();

    if (tutorialDoc.exists) {
      setState(() {
        tutorialText = tutorialDoc['texto'] as String;
        textToReadList.addAll(tutorialText!.split(RegExp(r'[,.]')));
        print(textToReadList);
      });
    } else {
      print('Documento não encontrado');
    }
  }

  Future<void> initializeTts() async {
    await flutterTts.setLanguage("pt-BR");
    await flutterTts.setPitch(1.0);
    await buscarTutorial(widget.id);
  }

  Future<void> speakCurrentPart() async {
    if (!isReading) {
      // if (currentIndex >= textToReadList.length) {
      //   currentIndex = 0;
      // }

      setState(() {
        isReading = true;
      });

      // String remainingText = textToReadList.sublist(currentIndex).join(" ");
      // print(remainingText);
      for (String frase in textToReadList) {
        await flutterTts.speak(frase);
        await Future.delayed(Duration(seconds: 10));
      }
    }
  }

  Future<void> pauseResumeReading() async {
    if (isReading) {
      // Pausar a leitura
      await flutterTts.stop();
      setState(() {
        isReading = false;
        // pauseIndex = currentIndex; // Salvar o índice de pausa
      });
    } else {
      // Retomar a leitura a partir do ponto de pausa
      // currentIndex = pauseIndex;
      speakCurrentPart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 13,
      width: MediaQuery.of(context).size.width / 7,
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isReading
                  ? Color.fromARGB(255, 0, 9, 89)
                  : const Color.fromARGB(0, 255, 255, 255)),
          child: const Image(
            image: AssetImage('images/headset.png'),
          ),
        ),
        onTap: () {
          pauseResumeReading();
        },
      ),
    );
  }
}
