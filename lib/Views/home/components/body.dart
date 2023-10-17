import 'package:flutter/material.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';
import 'package:how_to/Views/home/components/other_tutorials.dart';
import 'package:how_to/Views/home/components/popular_tutorials.dart';
import 'package:how_to/Views/home/components/profile_panel.dart';

class Body extends StatefulWidget {
  const Body({Key? key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;
  TtsService ttsService = TtsService();

  @override
  void dispose() {
    ttsService.dispose(); // Pare a leitura ao sair do widget
    super.dispose();
  }

  void readTitle(int index) async {
    List<String> titles = ["Tutoriais populares", "Outros tutoriais"];

    await ttsService.speak(titles[index]);
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
                      child: GestureDetector(
                        onTap: () {
                          isAccessibilityEnabled ? readTitle(0) : null;
                        },
                        child: Text(
                          'Tutoriais populares',
                          style: TextStyle(
                              fontSize: isAccessibilityEnabled ? 30 : 20),
                        ),
                      ),
                    ),
                    const PopularTutorials(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          isAccessibilityEnabled ? readTitle(1) : null;
                        },
                        child: Text(
                          'Outros tutoriais',
                          style: TextStyle(
                              fontSize: isAccessibilityEnabled ? 30 : 20),
                        ),
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
