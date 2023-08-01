import 'package:flutter/material.dart';
import 'package:how_to/Views/appBar/appBar_home.dart';
import 'package:how_to/Views/changeProfile/components/body.dart';

class ChangeProfilePage extends StatelessWidget {
  const ChangeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: MyAppBarHome(), body: Body());
  }
}
