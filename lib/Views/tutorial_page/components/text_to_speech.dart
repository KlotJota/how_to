import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TextToSpeech extends StatefulWidget {
  final String id;
  const TextToSpeech(this.id, {super.key});

  @override
  State<TextToSpeech> createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {
  final FlutterTts flutterTts = FlutterTts();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot<Object?>? tutorial;

  bool isReading = false;
  List<String> textToReadList = [];
  int currentIndex =
      0; // ambas variaveis cuidarão do sistema de pausa e retorno

  @override
  void initState() {
    super.initState();
    initializeTts();
    buscarTutorial(widget.id);
  }

  @override
  void dispose() {
    flutterTts.stop(); // Pare a leitura ao sair do widget
    super.dispose();
  }

  Future<void> buscarTutorial(String id) async {
    final tutorialDoc =
        await FirebaseFirestore.instance.collection('tutoriais').doc(id).get();
    setState(() {
      tutorial = tutorialDoc;
      textToReadList.add(tutorial!['texto']);
    });
  }

  Future<void> initializeTts() async {
    await flutterTts.setLanguage("pt-BR");
    await flutterTts.setPitch(1);
    await buscarTutorial(widget.id);
  }

  Future<void> readTutorial() async {
    try {
      // Processar os dados (por exemplo, concatenar títulos de documentos)
      // String textToRead = '';
      // querySnapshot.docs.forEach((doc) {
      //   textToRead += doc.data()!['titulo'] +
      //       '. '; // Supondo que você queira ler os títulos dos documentos
      // });
      await flutterTts.setLanguage("pt-BR");
      currentIndex = 0;
      await speakCurrentPart();
    } catch (e) {
      // Lidar com erros, como erro de conexão com o Firestore
      setState(() {
        isReading = false;
      });
    }
  }

  Future<void> speakCurrentPart() async {
    if (currentIndex < textToReadList.length) {
      await flutterTts.speak(textToReadList[currentIndex]);
      setState(() {
        isReading = true;
      });
      currentIndex++;
    }
  }

  Future<void> resumeReading() async {
    if (!isReading && currentIndex < textToReadList.length) {
      await speakCurrentPart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: GestureDetector(
        child: Icon(Icons.voice_chat, size: 40),
        onTap: () {
          speakCurrentPart();
        },
        onDoubleTap: () {
          flutterTts.stop();
        },
      ),
    );
  }
}
