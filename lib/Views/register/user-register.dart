import 'package:flutter/material.dart';
import 'package:how_to/Views/appBar/appBar.dart';
import 'package:how_to/Views/register/components/body.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({super.key});

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(),
      body: Body(),
    );
  }
}
