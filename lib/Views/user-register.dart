import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/user-login.dart';

class UserRegisterPage extends StatefulWidget {
  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Color.fromRGBO(0, 9, 89, 1);
    }
    return Color.fromRGBO(0, 9, 89, 1);
  }

  final _formKey = GlobalKey<FormState>();

  String _password = '';

  String _confirmPassword = '';

  bool isChecked = false;

  void _popUp(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                Text(
                    'Termos de Uso do Aplicativo How To \n\nBem-vindo ao aplicativo How To. Ao usar nosso aplicativo, você concorda com os seguintes termos e condições de uso. Se você não concorda com estes termos, não use o aplicativo.\n\nPropriedade Intelectual\n\nO aplicativo How To é propriedade exclusiva da empresa desenvolvedora e detentora dos direitos autorais e de propriedade intelectual relacionados ao aplicativo. Você concorda em não copiar, modificar, distribuir ou criar obras derivadas do aplicativo sem autorização prévia por escrito da empresa.\n\nUso Permitido\n\nO aplicativo How To é fornecido apenas para uso pessoal e não comercial. Você pode baixar o aplicativo e usá-lo em um único dispositivo móvel. Você concorda em não usar o aplicativo para fins ilegais, incluindo, mas não se limitando a, fraudes, spam ou invasão de privacidade de outros usuários.\n\nConteúdo do Usuário\n\nO aplicativo How To permite que você compartilhe conteúdo com outros usuários, incluindo comentários, avaliações e sugestões. Você é o único responsável pelo conteúdo que compartilha e garante que esse conteúdo não infringe nenhum direito de propriedade intelectual ou privacidade de terceiros. A empresa reserva-se o direito de remover qualquer conteúdo que viole esses termos ou a legislação aplicável.\n\nResponsabilidade Limitada\n\nO aplicativo How To é fornecido "como está" e a empresa não oferece nenhuma garantia sobre sua funcionalidade ou desempenho. Em nenhuma circunstância a empresa será responsável por danos diretos, indiretos, incidentais, especiais ou consequenciais decorrentes do uso ou incapacidade de uso do aplicativo.\n\nAlterações nos Termos de Uso\n\nA empresa reserva-se o direito de modificar estes termos de uso a qualquer momento e sem aviso prévio. O uso continuado do aplicativo após a publicação de novos termos de uso constitui aceitação desses termos.\n\nLei Aplicável\n\nEstes termos de uso são regidos e interpretados de acordo com as leis do Brasil. Qualquer disputa decorrente do uso do aplicativo How To será resolvida por meio de arbitragem de acordo com as regras da Câmara de Arbitragem do Brasil.\n\nAo usar o aplicativo How To, você reconhece que leu e concorda com estes termos de uso. Se você tiver alguma dúvida ou preocupação sobre esses termos, entre em contato com a empresa desenvolvedora do aplicativo.'),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 9, 89, 1),
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.only(top: 5),
                    width: 10,
                    height: 30,
                    child: Text(
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
    return Scaffold(
      body: Stack(
        key: _formKey,
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      scale: 19,
                      alignment: Alignment.topCenter,
                      image: AssetImage('images/how-to-branco.png'))),
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 9, 89, 1),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            top: 70,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 8,
                      blurRadius: 10,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Color.fromARGB(255, 240, 240, 240)),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.arrow_back_outlined,
                        color: Color.fromRGBO(0, 9, 89, 1),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      "Cadastro",
                      style: TextStyle(fontSize: 60),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width - 200,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_box_outlined,
                        ),
                        labelText: "Nome Completo",
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório.';
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width - 200,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        labelText: "E-mail",
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    margin: EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width - 200,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: "Senha",
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '';
                        }
                        if (value.length < 6) {
                          return 'Senha muito curta';
                        }
                        _password = value;
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width - 200,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.check),
                        labelText: "Confirmar senha",
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor confirme a senha';
                        }
                        if (_password != value) {
                          return 'As senhas não coincidem';
                        }
                        _confirmPassword = value;
                        return null;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            }),
                      ),
                      Text(
                        'Concordo com os',
                      ),
                      GestureDetector(
                        onTap: () {
                          _popUp(context);
                        },
                        child: Text(
                          ' termos de uso',
                          style: TextStyle(color: Color.fromRGBO(0, 9, 89, 1)),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () =>
                        Get.to(UserLoginPage(), transition: Transition.zoom),
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width - 200,
                      height: 40,
                      padding: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 9, 89, 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        'Cadastrar-se',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
