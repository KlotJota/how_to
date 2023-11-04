import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';

class TextToSpeech extends StatefulWidget {
  final String id;
  const TextToSpeech(this.id, {Key? key}) : super(key: key);

  @override
  State<TextToSpeech> createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {
  TtsService ttsService = TtsService();
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
    buscarTutorial(widget.id);
    // currentIndex = 0;
  }

  @override
  void dispose() {
    ttsService.dispose();
    // Pare a leitura ao sair do widget
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

  Future<void> speakCurrentPart() async {
    if (!isReading) {
      setState(() {
        isReading = true;
      });

      // String remainingText = textToReadList.sublist(currentIndex).join(" ");
      // print(remainingText);
      // for (String frase in textToReadList) {
      //   await ttsService.speak(frase);
      //   await Future.delayed(Duration(seconds: 10));
      // }
      ttsService.speak(tutorialText!);
    }
  }

  Future<void> pauseResumeReading() async {
    if (isReading) {
      // Pausar a leitura
      ttsService.dispose();
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
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Color.fromRGBO(0, 9, 89, 1)),
        child: Icon(
          Icons.headset_mic_outlined,
          color: Colors.white,
          size: isReading ? 40 : 30,
        ),
      ),
      onTap: () {
        pauseResumeReading();
      },
    );
  }
}
