import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  FlutterTts flutterTts = FlutterTts();

  TtsService() {
    initializeTts();
  }

  Future<void> initializeTts() async {
    await flutterTts.setLanguage("pt-BR");
    await flutterTts.setPitch(1.0);
  }

  Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }

  void dispose() {
    flutterTts.stop(); // Pare a leitura quando necessário
  }
}
