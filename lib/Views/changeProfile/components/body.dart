import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/register/components/register-form.dart';
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

  void _popUpSucesso(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 10,
          titlePadding: const EdgeInsets.all(5),
          title: const Text('Sucesso'),
          backgroundColor: const Color.fromARGB(255, 248, 246, 246),
          content: const Text(
              'Você será redirecionado para a tela de login para que as mudanças sejam aplicadas.'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    Get.offAll(const UserLoginPage());
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
            title: const Text('Erro'),
            backgroundColor: const Color.fromARGB(255, 248, 246, 246),
            content: const Text('A senha inserida está incorreta'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
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
              title: const Text('Confirmar senha'),
              backgroundColor: const Color.fromARGB(255, 240, 240, 240),
              content: const Text(
                  'Você precisa confirmar sua indentidade para realizar essa ação'),
              actions: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width - 120,
                      child: Form(
                        key: formKeyConfirm,
                        child: TextFormField(
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
                          onTap: () => Get.back(),
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
                          onTap: () =>
                              _reautenticarUsuario(senhaController.text),
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
          title: const Text('Escolher imagem'),
          backgroundColor: const Color.fromARGB(255, 240, 240, 240),
          content: pickedFile == null
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      pegaImagem();
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
                  onTap: () async {
                    await Future.delayed(Duration.zero)
                        .then((_) => adicionaImagem());
                    Get.back();

                    setState(() {});
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
                child: Text(
                  'Alterar Perfil',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                )),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: GestureDetector(
                  onTap: () {
                    _popUpImagem(context);
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
                    : Text(
                        auth.currentUser!.displayName.toString(),
                        style: const TextStyle(fontSize: 18),
                      )),
            const Divider(height: 10, thickness: 1),
            Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  'Nome de usuário',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
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
                child: Text(
                  'Endereço de e-mail da conta',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                )),
            Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  auth.currentUser!.email.toString(),
                  style: const TextStyle(fontSize: 16),
                )),
            GestureDetector(
              onTap: () => {
                _popUpConfirmaSenha(context),
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
