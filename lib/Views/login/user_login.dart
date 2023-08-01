import 'package:flutter/material.dart';
import 'package:how_to/Views/appBar/appBar.dart';
import 'package:how_to/Views/login/components/body.dart';

class UserLoginPage extends StatelessWidget {
  const UserLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: MyAppBar(), body: Body());
  }
}
