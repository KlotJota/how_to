import 'package:flutter/material.dart';
import 'package:how_to/Views/reset_password/components/reset_pass_button.dart';
import 'package:how_to/Views/reset_password/components/send_mail_form.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(0, 9, 89, 1),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        scale: 19,
                        alignment: Alignment.topCenter,
                        image: AssetImage('images/how-to-branco.png'))),
              ),
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
                        offset: const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    color: const Color.fromARGB(255, 250, 247, 247)),
                child: const Column(
                  children: [SendMailForm(), ResetPassButton()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
