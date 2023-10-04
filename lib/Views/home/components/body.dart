import 'package:flutter/material.dart';
import 'package:how_to/Views/home/components/other_tutorials.dart';
import 'package:how_to/Views/home/components/popular_tutorials.dart';
import 'package:how_to/Views/home/components/profile_panel.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Body extends StatefulWidget {
  const Body({Key? key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FlutterTts flutterTts = FlutterTts();
  bool isReadingPopularTutorials = false;
  bool isReadingOtherTutorials = false;

  @override
  void initState() {
    super.initState();
    initializeTts();

    // Configurar o completionHandler para detectar quando a leitura é concluída
    flutterTts.setCompletionHandler(() {
      setState(() {
        isReadingPopularTutorials =
            false; // Definir como false quando a leitura for concluída
        isReadingOtherTutorials =
            false; // Definir como false quando a leitura for concluída
      });
    });
  }

  @override
  void dispose() {
    flutterTts.stop(); // Pare a leitura ao sair do widget
    super.dispose();
  }

  Future<void> initializeTts() async {
    await flutterTts.setLanguage("pt-BR");
    await flutterTts.setPitch(1.0);
  }

  void readTitle(int index) async {
    List<String> titles = ["Tutoriais populares", "Outros tutoriais"];

    await flutterTts.speak(titles[index]);

    setState(() {
      if (index == 0) {
        isReadingPopularTutorials = true;
      } else if (index == 1) {
        isReadingOtherTutorials = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      height: 60,
                      width: MediaQuery.of(context).size.width - 20,
                      child: const ProfilePanel(),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Tutoriais populares',
                            style: TextStyle(fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (!isReadingPopularTutorials) {
                                readTitle(0);
                              } else {
                                flutterTts.stop();
                              }
                              setState(() {
                                isReadingPopularTutorials =
                                    !isReadingPopularTutorials;
                              });
                            },
                            child: Container(
                              child: isReadingPopularTutorials
                                  ? Icon(Icons.mic)
                                  : Icon(Icons.mic_none),
                            ),
                          )
                        ],
                      ),
                    ),
                    const PopularTutorials(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Outros tutoriais',
                            style: TextStyle(fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (!isReadingOtherTutorials) {
                                readTitle(1);
                              } else {
                                flutterTts.stop();
                              }
                              setState(() {
                                isReadingOtherTutorials =
                                    !isReadingOtherTutorials;
                              });
                            },
                            child: Container(
                              child: isReadingOtherTutorials
                                  ? Icon(Icons.mic)
                                  : Icon(Icons.mic_none),
                            ),
                          )
                        ],
                      ),
                    ),
                    const OtherTutorials(),
                  ],
                ),
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}
