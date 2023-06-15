import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/register/components/body.dart';

class UserRegisterPage extends StatefulWidget {
  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
