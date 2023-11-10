import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';
import 'package:how_to/Views/appBar/appBar_profile.dart';
import 'package:how_to/Views/drawer_menu/drawer_menu.dart';
import 'package:how_to/Views/edit_tutorial/tutorialEdit-page.dart';
import 'package:how_to/Views/face_detector/face_detector_page.dart';
import 'package:how_to/Views/tutorial_page/components/text_to_speech.dart';
import 'package:how_to/Views/tutorial_page/components/tutorial_image.dart';
import 'package:how_to/Views/tutorial_page/components/tutorial_text.dart';
import 'package:how_to/Views/tutorial_page/components/tutorial_title.dart';
import '../first_pages/first_page.dart';
import '../register/user-register.dart';

class TutorialPage extends StatefulWidget {
  final String id;
  const TutorialPage(this.id, {super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DocumentSnapshot<Object?>? tutorial;

  List<String> favoritos = [];

  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;
  TtsService ttsService = TtsService();

  @override
  void initState() {
    super.initState();
    buscarTutorial(widget.id);
    buscarFavorito();
  }

  void popUpRegister() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 10,
            titlePadding: const EdgeInsets.all(5),
            title: const Text('Criar conta'),
            backgroundColor: const Color.fromARGB(255, 250, 247, 247),
            content: const Text(
              'Você deve criar uma conta para poder adicionar tutoriais aos favoritos e consultar sua Área de usuário',
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.only(top: 5),
                      height: 30,
                      width: 80,
                      child: const Text(
                        'Fechar',
                        style: TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const UserRegisterPage());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 9, 89, 1),
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.only(top: 5),
                      height: 30,
                      width: 85,
                      child: const Text(
                        'Criar conta',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }

  void buscarTutorial(String id) async {
    final tutorialDoc = await FirebaseFirestore.instance
        .collection('tutoriais')
        .doc(widget.id)
        .get();
    setState(() {
      tutorial = tutorialDoc;
    });
  }

  void deletar(String id) {
    firestore.collection('tutoriais').doc(id).delete();
    Get.to(const FirstPage());
  }

  final user = FirebaseAuth.instance.currentUser;

  bool isLogado() {
    if (user!.uid == "vapEyTsxGoWsOcUObGDywxz4WpC2" ||
        user!.uid == "bP234QxmIsPth7PqwzosZyfNMvk2" ||
        user!.uid == "YTzsr7KMKzezqsCbNxdsHHhSvGc2") {
      return true;
    }
    return false;
  }

  void buscarFavorito() async {
    final tutorialDoc = await FirebaseFirestore.instance
        .collection('favoritos')
        .doc(auth.currentUser!.uid)
        .get();

    if (tutorialDoc.exists) {
      List<dynamic> favoritosDocument = tutorialDoc.data()?['Favoritos'] ?? [];
      favoritos =
          favoritosDocument.map((favorito) => favorito.toString()).toList();

      setState(() {});
    }
  }

  void removerFavorito(String tutorialId) async {
    // Remove o tutorial da lista de favoritos
    favoritos.removeWhere((favorito) => favorito == tutorialId);

    // Atualiza a coleção "favoritos" no Firestore
    await FirebaseFirestore.instance
        .collection('favoritos')
        .doc(auth.currentUser!.uid)
        .update({'Favoritos': favoritos});

    // Atualiza o estado para refletir a remoção do tutorial
    setState(() {
      favoritos.length;
    });
  }

  void popupDelete() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 10,
            titlePadding: const EdgeInsets.all(5),
            title: const Text('Excluir'),
            backgroundColor: const Color.fromARGB(255, 250, 247, 247),
            content: const Text(
                'Deseja realmente EXCLUIR esse tutorial da base de dados?'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.only(top: 5),
                      height: 30,
                      width: 80,
                      child: const Text(
                        'Não',
                        style: TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      deletar(tutorial!.id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 9, 89, 1),
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.only(top: 5),
                      height: 30,
                      width: 80,
                      child: const Text(
                        'Sim',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          endDrawer: Drawer(
            child: DrawerMenuContent(),
          ),
          appBar: MyAppBarProfile(),
          body: tutorial == null
              ? const CircularProgressIndicator()
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Column(
                          children: [
                            TutorialImage(widget.id),
                            TutorialTitle(widget.id),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextToSpeech(tutorial!.id),
                                GestureDetector(
                                  onTap: () {
                                    HapticFeedback.heavyImpact();
                                    if (isAccessibilityEnabled) {
                                      if (!favoritos.contains(tutorial!.id)) {
                                        ttsService.speak(
                                            'Tutorial adicionado aos favoritos');
                                      } else {
                                        ttsService.speak(
                                            'Tutorial removido dos favoritos');
                                      }
                                    }
                                    setState(() {
                                      if (auth.currentUser!.displayName !=
                                          null) {
                                        if (!favoritos.contains(tutorial!.id)) {
                                          FirebaseFirestore.instance
                                              .collection('favoritos')
                                              .doc(auth.currentUser!.uid)
                                              .set({
                                            "Favoritos": FieldValue.arrayUnion(
                                                [tutorial!.id])
                                          }, SetOptions(merge: true));
                                          FirebaseFirestore.instance
                                              .collection('tutoriais')
                                              .doc(tutorial!.id)
                                              .update({
                                            "qtdFavoritos":
                                                FieldValue.increment(1),
                                          });
                                          favoritos.add(tutorial!
                                              .id); // Adiciona o tutorial aos favoritos
                                        } else {
                                          Future.delayed(Duration.zero).then(
                                              (_) => removerFavorito(
                                                  tutorial!.id));

                                          FirebaseFirestore.instance
                                              .collection('tutoriais')
                                              .doc(tutorial!.id)
                                              .update({
                                            "qtdFavoritos":
                                                FieldValue.increment(-1),
                                          });

                                          favoritos.remove(tutorial!
                                              .id); // Remove o tutorial dos favoritos
                                        }
                                      } else {
                                        popUpRegister();
                                      }
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 0),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(2, 2),
                                          blurRadius: 5,
                                          spreadRadius: 0,
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      color: favoritos.contains(tutorial!.id)
                                          ? const Color.fromARGB(
                                              255, 226, 173, 0)
                                          : Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.star,
                                      size: isAccessibilityEnabled ? 45 : 35,
                                      color: favoritos.contains(tutorial!.id)
                                          ? Colors.white
                                          : const Color.fromARGB(
                                              255, 230, 230, 230),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onDoubleTap: () {
                                    if (isAccessibilityEnabled) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FaceDetectorPage(tutorial!.id),
                                        ),
                                      );
                                      HapticFeedback.heavyImpact();
                                    }
                                  },
                                  onTap: () {
                                    HapticFeedback.heavyImpact();
                                    isAccessibilityEnabled
                                        ? ttsService.speak(
                                            'Dê um duplo clique para ativar o detector facial')
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FaceDetectorPage(
                                                      tutorial!.id),
                                            ),
                                          );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(2, 2),
                                            blurRadius: 5,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                        shape: BoxShape.circle,
                                        color: Color.fromRGBO(0, 9, 89, 1)),
                                    child: Icon(
                                      Icons.face,
                                      color: Colors.white,
                                      size: isAccessibilityEnabled ? 40 : 30,
                                    ),
                                  ),
                                ),
                                isLogado()
                                    ? IconButton(
                                        onPressed: () {
                                          if (auth.currentUser!.displayName !=
                                              null) {
                                            Get.to(() =>
                                                TutorialEditPage(tutorial!.id));
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      )
                                    : Container(),
                                isLogado()
                                    ? IconButton(
                                        onPressed: () {
                                          if (auth.currentUser!.displayName !=
                                              null) {
                                            popupDelete();
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Color.fromARGB(255, 175, 0, 0),
                                        ),
                                        iconSize: 35,
                                        color: const Color.fromARGB(
                                            255, 179, 179, 179),
                                      )
                                    : Container(),
                              ],
                            ),
                            TutorialText(widget.id)
                          ],
                        ),
                        Container(
                          height: 100,
                        )
                      ]))),
    );
  }
}
