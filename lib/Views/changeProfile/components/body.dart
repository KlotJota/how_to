import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import '../../login/user_login.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

DateTime dataAtual = DateTime.now();
FirebaseAuth auth = FirebaseAuth.instance;

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var novoNomeKey = GlobalKey<FormState>();

  XFile? pickedFile;
  String? imageUrl;

  String nome = auth.currentUser!.displayName.toString();
  String novoNome = auth.currentUser!.displayName.toString();

  String dataFormatada = dataAtual.toString();

  final senhaController = TextEditingController();

  final formKeyConfirm = GlobalKey<FormState>();

  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;
  TtsService ttsService = TtsService();

  void _popUpSucesso(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 10,
          titlePadding: const EdgeInsets.all(5),
          title: GestureDetector(
              onTap: () {
                if (isAccessibilityEnabled) {
                  ttsService.speak('Sucesso');
                  HapticFeedback.heavyImpact();
                }
              },
              child: const Text('Sucesso')),
          backgroundColor: const Color.fromARGB(255, 248, 246, 246),
          content: GestureDetector(
            onTap: () {
              if (isAccessibilityEnabled) {
                ttsService.speak(
                    'Você será redirecionado para a tela de login para que as mudanças sejam aplicadas.');
                HapticFeedback.heavyImpact();
              }
            },
            child: const Text(
                'Você será redirecionado para a tela de login para que as mudanças sejam aplicadas.'),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onDoubleTap: () {
                    if (isAccessibilityEnabled) {
                      Get.offAll(const UserLoginPage());
                      HapticFeedback.heavyImpact();
                    }
                  },
                  onTap: () async {
                    HapticFeedback.heavyImpact();
                    isAccessibilityEnabled
                        ? ttsService.speak('Dê um duplo clique para voltar')
                        : Get.offAll(const UserLoginPage());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 9, 89, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.only(top: 5),
                    height: 30,
                    width: 80,
                    child: const Text(
                      'Voltar',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  void _popUpErro(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 10,
            titlePadding: const EdgeInsets.all(5),
            title: GestureDetector(
                onTap: () {
                  if (isAccessibilityEnabled) {
                    ttsService.speak('Erro');
                    HapticFeedback.heavyImpact();
                  }
                },
                child: const Text('Erro')),
            backgroundColor: const Color.fromARGB(255, 248, 246, 246),
            content: GestureDetector(
                onTap: () {
                  if (isAccessibilityEnabled) {
                    ttsService.speak('A senha inserida está incorreta');
                    HapticFeedback.heavyImpact();
                  }
                },
                child: const Text('A senha inserida está incorreta')),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onDoubleTap: () {
                      if (isAccessibilityEnabled) {
                        Get.back();
                        HapticFeedback.heavyImpact();
                      }
                    },
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      isAccessibilityEnabled
                          ? ttsService.speak('Dê um duplo clique para voltar')
                          : Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 9, 89, 1),
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.only(top: 5),
                      height: 30,
                      width: 80,
                      child: const Text(
                        'Voltar',
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

  void alteraUser(BuildContext context, String newDisplayName) async {
    await FirebaseFirestore.instance
        .collection('userInfo')
        .doc(auth.currentUser!.uid)
        .set({"Tempo": dataFormatada});

    try {
      await FirebaseAuth.instance.currentUser!
          .updateDisplayName(newDisplayName);
      await FirebaseAuth.instance.currentUser!.reload();

      setState(() {});
      _popUpSucesso(context);
    } catch (e) {
      print(e.toString());
      _popUpErro(context);
    }
  }

  void _reautenticarUsuario(String senha) async {
    String senha = senhaController.text;
    AuthCredential credential = EmailAuthProvider.credential(
      email: auth.currentUser!.email.toString(),
      password: senha,
    );

    try {
      await auth.currentUser!.reauthenticateWithCredential(credential);
      alteraUser(context, novoNome);
    } catch (e) {
      print('Erro na reautenticação: $e');
      _popUpErro(context);
    }
  }

  void _popUpConfirmaSenha(context) {
    if (novoNomeKey.currentState!.validate()) {
      novoNomeKey.currentState!.save();
      try {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              elevation: 10,
              titlePadding: const EdgeInsets.all(5),
              title: GestureDetector(
                  onTap: () {
                    if (isAccessibilityEnabled) {
                      ttsService.speak('Confirmar senha');
                      HapticFeedback.heavyImpact();
                    }
                  },
                  child: const Text('Confirmar senha')),
              backgroundColor: const Color.fromARGB(255, 240, 240, 240),
              content: GestureDetector(
                onTap: () {
                  if (isAccessibilityEnabled) {
                    ttsService.speak(
                        'Você precisa confirmar sua identidade para realizar essa ação');
                    HapticFeedback.heavyImpact();
                  }
                },
                child: const Text(
                    'Você precisa confirmar sua indentidade para realizar essa ação'),
              ),
              actions: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width - 120,
                      child: Form(
                        key: formKeyConfirm,
                        child: TextFormField(
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            isAccessibilityEnabled
                                ? ttsService.speak('Insira sua senha')
                                : null;
                          },
                          controller: senhaController,
                          decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 9, 89, 1),
                                    width: 2),
                              ),
                              border: OutlineInputBorder(),
                              labelText: "Insira sua senha",
                              labelStyle:
                                  TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15)),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Você precisa inserir sua senha';
                            }

                            return null;
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onDoubleTap: () {
                            if (isAccessibilityEnabled) {
                              Get.back();
                              HapticFeedback.heavyImpact();
                            }
                          },
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            isAccessibilityEnabled
                                ? ttsService
                                    .speak('Dê um duplo clique para cancelar')
                                : Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 5),
                            margin: const EdgeInsets.only(top: 10),
                            height: 30,
                            width: 80,
                            child: const Text(
                              'Cancelar',
                              style:
                                  TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onDoubleTap: () {
                            if (isAccessibilityEnabled) {
                              _reautenticarUsuario(senhaController.text);
                              HapticFeedback.heavyImpact();
                            }
                          },
                          onTap: () {
                            HapticFeedback.heavyImpact();
                            isAccessibilityEnabled
                                ? ttsService
                                    .speak('Dê um duplo clique para confirmar')
                                : _reautenticarUsuario(senhaController.text);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(0, 9, 89, 1),
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.only(top: 5),
                            margin: const EdgeInsets.only(top: 10),
                            height: 30,
                            width: 80,
                            child: const Text(
                              'Confirmar',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            );
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> pegaImagem() async {
    final ImagePicker picker = ImagePicker();
    try {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void adicionaImagem() async {
    if (pickedFile != null) {
      File imageFile = File(pickedFile!.path);

      String imagemRef =
          "perfis/personalizado/${auth.currentUser?.uid}/img-${DateTime.now().toString()}.jpg";
      Reference storageRef = FirebaseStorage.instance.ref().child(imagemRef);
      await storageRef.putFile(imageFile);

      // Obter URL da imagem
      imageUrl = await storageRef.getDownloadURL();

      await auth.currentUser!.updatePhotoURL(imageUrl);
      setState(() {});
    }
  }

  void _popUpImagem(context) async {
    await pegaImagem();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          titlePadding: const EdgeInsets.all(5),
          title: GestureDetector(
              onTap: () {
                if (isAccessibilityEnabled) {
                  ttsService.speak('Escolher imagem');
                  HapticFeedback.heavyImpact();
                }
              },
              child: const Text('Escolher imagem')),
          backgroundColor: const Color.fromARGB(255, 240, 240, 240),
          content: pickedFile == null
              ? GestureDetector(
                  onDoubleTap: () {
                    if (isAccessibilityEnabled) {
                      pegaImagem();
                      HapticFeedback.heavyImpact();
                    }
                  },
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    setState(() {
                      isAccessibilityEnabled
                          ? ttsService.speak(
                              'Dê um duplo clique para selecionar uma imagem')
                          : pegaImagem();
                    });
                  },
                  child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 243, 243, 243),
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 112, 112, 112)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(child: const Icon(Icons.add)),
                          const Text("Selecione uma imagem"),
                        ],
                      )))
              : SizedBox(
                  width: 200,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(pickedFile!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onDoubleTap: () {
                    if (isAccessibilityEnabled) {
                      Get.back();
                      HapticFeedback.heavyImpact();
                    }
                  },
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    isAccessibilityEnabled
                        ? ttsService.speak('Dê um duplo clique para fechar')
                        : Get.back();
                  },
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
                  onDoubleTap: () async {
                    if (isAccessibilityEnabled) {
                      HapticFeedback.heavyImpact();
                      await Future.delayed(Duration.zero)
                          .then((_) => adicionaImagem());
                      Get.back();

                      setState(() {});
                    }
                  },
                  onTap: () async {
                    HapticFeedback.heavyImpact();
                    if (!isAccessibilityEnabled) {
                      await Future.delayed(Duration.zero)
                          .then((_) => adicionaImagem());
                      Get.back();

                      setState(() {});
                    } else {
                      ttsService
                          .speak('Dê um duplo clique para adicionar a imagem');
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 9, 89, 1),
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.only(top: 5),
                    height: 30,
                    width: 80,
                    child: const Text(
                      'Adicionar ',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    novoNome = auth.currentUser!.displayName.toString();
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            Container(
                margin: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    if (isAccessibilityEnabled) {
                      ttsService.speak('Alterar perfil');
                      HapticFeedback.heavyImpact();
                    }
                  },
                  child: Text(
                    'Alterar Perfil',
                    style: TextStyle(
                        fontSize: isAccessibilityEnabled ? 24 : 18,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: GestureDetector(
                  onDoubleTap: () {
                    if (isAccessibilityEnabled) {
                      _popUpImagem(context);
                      HapticFeedback.heavyImpact();
                    }
                  },
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    isAccessibilityEnabled
                        ? ttsService
                            .speak('Dê um duplo clique para alterar sua imagem')
                        : _popUpImagem(context);
                  },
                  child: CircleAvatar(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(96, 0, 0, 0),
                      ),
                      child: Icon(Icons.photo, size: 30),
                    ),
                    backgroundImage:
                        NetworkImage(auth.currentUser!.photoURL.toString()),
                    radius: 50,
                  )),
            ),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10),
                child: auth.currentUser!.displayName == null
                    ? const Text(
                        'Usuário',
                        style: TextStyle(fontSize: 18),
                      )
                    : GestureDetector(
                        onTap: () {
                          if (isAccessibilityEnabled) {
                            ttsService.speak(
                                auth.currentUser!.displayName.toString());
                            HapticFeedback.heavyImpact();
                          }
                        },
                        child: Text(
                          auth.currentUser!.displayName.toString(),
                          style: TextStyle(
                              fontSize: isAccessibilityEnabled ? 24 : 18),
                        ),
                      )),
            const Divider(height: 10, thickness: 1),
            Container(
                margin: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    if (isAccessibilityEnabled) {
                      ttsService.speak('Nome de usuário');
                      HapticFeedback.heavyImpact();
                    }
                  },
                  child: Text(
                    'Nome de usuário',
                    style: TextStyle(
                        fontSize: isAccessibilityEnabled ? 24 : 18,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            Container(
              padding: EdgeInsets.only(top: 20),
              margin: const EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width - 50,
              child: Form(
                key: novoNomeKey,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                    ),
                    prefixIcon: Icon(
                      Icons.account_box_outlined,
                    ),
                  ),
                  textAlign: TextAlign.left,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    isAccessibilityEnabled
                        ? ttsService.speak('Insira seu novo nome de usuário')
                        : null;
                  },
                  onChanged: (value) => novoNome = value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, informe seu nome.';
                    } else if (value == nome) {
                      return 'O nome inserido é igual ao anterior.';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    if (isAccessibilityEnabled) {
                      ttsService.speak('Endereço de email da conta');
                      HapticFeedback.heavyImpact();
                    }
                  },
                  child: Text(
                    'Endereço de e-mail da conta',
                    style: TextStyle(
                        fontSize: isAccessibilityEnabled ? 24 : 18,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            Container(
                margin: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    if (isAccessibilityEnabled) {
                      ttsService.speak(
                        auth.currentUser!.email.toString(),
                      );
                      HapticFeedback.heavyImpact();
                    }
                  },
                  child: Text(
                    auth.currentUser!.email.toString(),
                    style:
                        TextStyle(fontSize: isAccessibilityEnabled ? 24 : 16),
                  ),
                )),
            GestureDetector(
              onDoubleTap: () {
                if (isAccessibilityEnabled) {
                  _popUpConfirmaSenha(context);
                  HapticFeedback.heavyImpact();
                }
              },
              onTap: () => {
                HapticFeedback.heavyImpact(),
                isAccessibilityEnabled
                    ? ttsService.speak(
                        'Dê um duplo clique para alterar o nome de usuário')
                    : _popUpConfirmaSenha(context)
              },
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                width: MediaQuery.of(context).size.width - 120,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 9, 89, 1),
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  'Alterar nome',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 250, 250, 250),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
