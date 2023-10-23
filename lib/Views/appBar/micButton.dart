import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';
import 'package:how_to/Views/search_page/search-page.dart';

import 'package:speech_to_text/speech_to_text.dart';
import 'package:get/get.dart';
import '../search_page/components/search.singleton.dart';

class MicButton extends StatefulWidget {
  @override
  _MicButtonState createState() => _MicButtonState();
}

class _MicButtonState extends State<MicButton> {
  SpeechToText speechToText = SpeechToText();

  bool _isPressed = false;

  SearchSingleton pesquisa = SearchSingleton.controller;
  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;
  TtsService ttsService = TtsService();

  @override
  void dispose() {
    ttsService.dispose(); // Pare a leitura ao sair do widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        HapticFeedback.heavyImpact();
        if (!_isPressed) {
          var disponivel = await speechToText.initialize();
          if (disponivel) {
            setState(() {
              _isPressed = true;
              speechToText.listen(
                onResult: (result) {
                  setState(() {
                    pesquisa.searchController.text = '';
                    pesquisa.searchController.text = result.recognizedWords;
                  });
                },
              );
            });
          }
        }
      },
      onLongPressEnd: (_) {
        setState(() {
          _isPressed = false;
        });
        speechToText.stop();
        if (pesquisa.searchController.text.isNotEmpty) {
          Get.to(SearchPage());
        }
      },
      child: _isPressed ? _buildContainer() : _buildFAB(),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      enableFeedback: true,
      onPressed: () {
        if (isAccessibilityEnabled) {
          ttsService.speak('Segure esse botão para pesquisar por voz');
          HapticFeedback.heavyImpact();
        }
      },
      child: Icon(
        Icons.mic_none,
      ),
    );
  }

  Widget _buildContainer() {
    // ThemeData currentTheme = Get.theme;

    return OrientationBuilder(
      builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;
        final containerHeight = isPortrait
            ? MediaQuery.of(context).size.height * 0.06
            : MediaQuery.of(context).size.height * 0.15;

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 9, 89, 0.596),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.7,
                height: containerHeight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      pesquisa.searchController.text,
                      style: TextStyle(
                        overflow: TextOverflow.clip,
                        color: _isPressed
                            ? Colors.white
                            : const Color.fromARGB(131, 255, 255, 255),
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
            FloatingActionButton(
              enableFeedback: true,
              onPressed: () {},
              child: Icon(Icons.mic),
            )
          ],
        );
      },
    );
  }
}
