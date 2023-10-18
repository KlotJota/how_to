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
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [SendMailForm(), ResetPassButton()],
            ),
          ),
        ),
      ),
    );
  }
}
