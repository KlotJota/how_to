import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';

import '../../login/user_login.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKeyRegister = GlobalKey<FormState>();

  String nome = '';
  String email = '';
  String password = '';
  String _confirmPassword = '';
  String imagem = '';
  bool isChecked = false;
  bool _passVisible = false;
  bool _checkPassVisible = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;
  TtsService ttsService = TtsService();

  String termos =
      'Termos de Uso do Aplicativo How To \n\nBem-vindo ao aplicativo How To. Ao usar nosso aplicativo, você concorda com os seguintes termos e condições de uso. Se você não concorda com estes termos, não use o aplicativo.\n\nPropriedade Intelectual\n\nO aplicativo How To é propriedade exclusiva da empresa desenvolvedora e detentora dos direitos autorais e de propriedade intelectual relacionados ao aplicativo. Você concorda em não copiar, modificar, distribuir ou criar obras derivadas do aplicativo sem autorização prévia por escrito da empresa.\n\nUso Permitido\n\nO aplicativo How To é fornecido apenas para uso pessoal e não comercial. Você pode baixar o aplicativo e usá-lo em um único dispositivo móvel. Você concorda em não usar o aplicativo para fins ilegais, incluindo, mas não se limitando a, fraudes, spam ou invasão de privacidade de outros usuários.\n\nConteúdo do Usuário\n\nO aplicativo How To permite que você compartilhe conteúdo com outros usuários, incluindo comentários, avaliações e sugestões. Você é o único responsável pelo conteúdo que compartilha e garante que esse conteúdo não infringe nenhum direito de propriedade intelectual ou privacidade de terceiros. A empresa reserva-se o direito de remover qualquer conteúdo que viole esses termos ou a legislação aplicável.\n\nResponsabilidade Limitada\n\nO aplicativo How To é fornecido "como está" e a empresa não oferece nenhuma garantia sobre sua funcionalidade ou desempenho. Em nenhuma circunstância a empresa será responsável por danos diretos, indiretos, incidentais, especiais ou consequenciais decorrentes do uso ou incapacidade de uso do aplicativo.\n\nAlterações nos Termos de Uso\n\nA empresa reserva-se o direito de modificar estes termos de uso a qualquer momento e sem aviso prévio. O uso continuado do aplicativo após a publicação de novos termos de uso constitui aceitação desses termos.\n\nLei Aplicável\n\nEstes termos de uso são regidos e interpretados de acordo com as leis do Brasil. Qualquer disputa decorrente do uso do aplicativo How To será resolvida por meio de arbitragem de acordo com as regras da Câmara de Arbitragem do Brasil.\n\nAo usar o aplicativo How To, você reconhece que leu e concorda com estes termos de uso. Se você tiver alguma dúvida ou preocupação sobre esses termos, entre em contato com a empresa desenvolvedora do aplicativo.';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ttsService.dispose();
  }

  void register(BuildContext context) async {
    if (formKeyRegister.currentState!.validate()) {
      formKeyRegister.currentState!.save();
      try {
        var result = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        result.user!.updateDisplayName(nome);

        Get.offAll(const UserLoginPage());
      } catch (e) {
        if (e is FirebaseAuthException) {
          if (e.message ==
              'The email address is already in use by another account.') {
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
                    content: GestureDetector(
                        onTap: () {
                          if (isAccessibilityEnabled) {
                            ttsService.speak(
                                'O email informado para cadastro já existe');
                            HapticFeedback.heavyImpact();
                          }
                        },
                        child: const Text(
                            'O email informado para cadastro já existe')),
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
                                  ? ttsService
                                      .speak('Dê um duplo clique para fechar')
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
                                'Ok',
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
        }
      }
    }
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return const Color.fromRGBO(0, 9, 89, 1);
    }
    return const Color.fromRGBO(0, 9, 89, 1);
  }

  void _popUp(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                GestureDetector(
                    onTap: () {
                      isAccessibilityEnabled ? ttsService.speak(termos) : null;
                    },
                    child: Text(termos)),
                GestureDetector(
                  onDoubleTap: () {
                    if (isAccessibilityEnabled) {
                      HapticFeedback.heavyImpact();
                      Get.back();
                      ttsService.dispose();
                    }
                  },
                  onTap: () {
                    HapticFeedback.heavyImpact();
                    if (!isAccessibilityEnabled) {
                      Get.back();
                      ttsService.dispose();
                    } else {
                      ttsService.speak('Dê um duplo clique para echar');
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 9, 89, 1),
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.only(top: 5),
                    width: 10,
                    height: 30,
                    child: const Text(
                      'Fechar',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeyRegister,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width - 120,
            child: TextFormField(
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2),
                ),
                prefixIcon: Icon(
                  Icons.account_box_outlined,
                ),
                labelText: "Nome Completo",
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onTap: () {
                HapticFeedback.heavyImpact();
                isAccessibilityEnabled
                    ? ttsService.speak('Insira seu nome completo')
                    : null;
              },
              onSaved: (value) => nome = value!,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, informe seu nome.';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width - 120,
            child: TextFormField(
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2),
                ),
                prefixIcon: Icon(Icons.mail),
                labelText: "E-mail",
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onTap: () {
                HapticFeedback.heavyImpact();
                isAccessibilityEnabled
                    ? ttsService.speak('Insira seu email')
                    : null;
              },
              onSaved: (value) => email = value!,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, insira um email.';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Por favor, insira um email válido.';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width - 120,
            child: TextFormField(
              obscureText: !_passVisible,
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(width: 2),
                ),
                prefixIcon: const Icon(Icons.lock),
                labelText: 'Senha',
                suffixIcon: IconButton(
                  icon: Icon(
                    _passVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    HapticFeedback.heavyImpact();
                    if (isAccessibilityEnabled) {
                      _passVisible
                          ? ttsService.speak('Senha invisível')
                          : ttsService.speak('Senha visível');
                    }
                    setState(() {
                      _passVisible = !_passVisible;
                    });
                  },
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onTap: () {
                HapticFeedback.heavyImpact();
                isAccessibilityEnabled
                    ? ttsService.speak('Insira sua senha')
                    : null;
              },
              onSaved: (value) => password = value!,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor insira uma senha';
                }
                if (value.length < 6) {
                  return 'Senha muito curta';
                }
                password = value;
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width - 120,
            child: TextFormField(
              obscureText: !_checkPassVisible,
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(width: 2),
                ),
                prefixIcon: const Icon(Icons.check),
                labelText: 'Confirmar Senha',
                suffixIcon: IconButton(
                  icon: Icon(
                    _checkPassVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    HapticFeedback.heavyImpact();
                    if (isAccessibilityEnabled) {
                      _passVisible
                          ? ttsService.speak('Senha invisível')
                          : ttsService.speak('Senha visível');
                    }
                    setState(() {
                      _checkPassVisible = !_checkPassVisible;
                    });
                  },
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onTap: () {
                HapticFeedback.heavyImpact();
                isAccessibilityEnabled
                    ? ttsService.speak('Confirme sua senha')
                    : null;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor confirme a senha';
                }
                if (password != value) {
                  return 'As senhas não coincidem';
                }
                _confirmPassword = value;
                return null;
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked,
                      onChanged: (bool? value) {
                        HapticFeedback.heavyImpact();
                        setState(() {
                          isChecked = value!;
                        });
                      }),
                ),
                GestureDetector(
                  onDoubleTap: () {
                    if (isAccessibilityEnabled) {
                      setState(() {
                        isChecked = !isChecked;
                      });
                      HapticFeedback.heavyImpact();
                    }
                  },
                  onTap: () {
                    if (isAccessibilityEnabled) {
                      ttsService.speak(
                          'Dê um duplo clique para concordar com os termos de uso');
                      HapticFeedback.heavyImpact();
                    }
                  },
                  child: Text(
                    'Concordo com os',
                    style:
                        TextStyle(fontSize: isAccessibilityEnabled ? 20 : 14),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onDoubleTap: () {
                      if (isAccessibilityEnabled) {
                        _popUp(context);
                        HapticFeedback.heavyImpact();
                      }
                    },
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      isAccessibilityEnabled
                          ? ttsService.speak(
                              'Dê um duplo clique para concordar com os termos de uso')
                          : _popUp(context);
                    },
                    child: Text(
                      ' termos de uso',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 9, 89, 1),
                          fontSize: isAccessibilityEnabled ? 20 : 14,
                          decoration: isAccessibilityEnabled
                              ? TextDecoration.underline
                              : null),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () {
              if (isAccessibilityEnabled) {
                register(context);
                HapticFeedback.heavyImpact();
              }
            },
            onTap: () {
              HapticFeedback.heavyImpact();
              if (!isChecked) {
                isAccessibilityEnabled
                    ? ttsService.speak(
                        'Você precisa concordar com os termos de uso antes de continuar')
                    : null;

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Erro de registro'),
                    content: const Text(
                        'Você deve concordar com os termos e condições.'),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              } else {
                isAccessibilityEnabled
                    ? ttsService.speak('Dê um duplo clique para se cadastrar')
                    : register(context);
              }
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width - 120,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 9, 89, 1),
                  borderRadius: BorderRadius.circular(5)),
              child: const Text(
                'Registrar',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
