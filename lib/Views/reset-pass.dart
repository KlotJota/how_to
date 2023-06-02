import 'package:flutter/material.dart';
import 'package:how_to/Views/first_page.dart';
import 'package:how_to/Views/first_page_anonymous.dart';
import 'package:how_to/Views/user-register.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class resetPassPage extends StatelessWidget {
  var logo = 'howto_logo1.png';

  final TextEditingController emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  void redenirSenha(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(
                    "Um e-mail de redefinição de senha foi enviado para ${emailController.text}."),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Ok"))
                ],
              ));
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Redefinir Senha'),
          content: Text(
              'Ocorreu um erro ao enviar o e-mail de redefinição de senha. Por favor, verifique o e-mail e tente novamente.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Stack(
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
                    color: Color.fromARGB(255, 250, 247, 247)),
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
                      margin: EdgeInsets.only(top: 30),
                      child: Image(
                        image: NetworkImage(
                          "https://cdn-icons-png.flaticon.com/512/6357/6357048.png",
                        ),
                        fit: BoxFit.contain,
                        width: 200,
                        height: 200,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                        "Esqueceu sua senha?",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Wrap(children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Se você esqueceu sua senha, não se preocupe! Podemos ajudá-lo a recuperar o acesso à sua conta.",
                          style: TextStyle(fontSize: 13),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ]),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width - 50,
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => redenirSenha(context),
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width - 50,
                        height: 40,
                        padding: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 9, 89, 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          'Enviar',
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
      ),
    );
  }
}
