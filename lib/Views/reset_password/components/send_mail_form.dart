import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:how_to/Views/reset_password/components/singleton.dart';

class SendMailForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
            controller: SingletonResetPass.controller.emailController,
            decoration: InputDecoration(
              labelText: 'E-mail',
              prefixIcon: Icon(Icons.email),
            ),
          ),
        ),
      ],
    );
  }
}
