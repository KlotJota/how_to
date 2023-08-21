import 'package:flutter/material.dart';

import 'package:speech_to_text/speech_to_text.dart';

class MicButton extends StatefulWidget {
  @override
  _MicButtonState createState() => _MicButtonState();
}

class _MicButtonState extends State<MicButton> {
  SpeechToText speechToText = SpeechToText();

  bool _isPressed = false;

  var texto = "Como atualizar o Windows";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        if (!_isPressed) {
          var disponivel = await speechToText.initialize();
          if (disponivel) {
            setState(() {
              _isPressed = true;
              speechToText.listen(
                onResult: (result) {
                  setState(() {
                    texto = result.recognizedWords;
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
        print(texto);
        speechToText.stop();
      },
      child: _isPressed ? _buildContainer() : _buildFAB(),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      enableFeedback: true,
      onPressed: () {},
      child: Icon(Icons.mic_none),
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
                      texto,
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
