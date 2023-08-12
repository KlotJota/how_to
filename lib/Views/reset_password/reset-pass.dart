import 'package:flutter/material.dart';
import 'package:how_to/Views/appBar/appBar.dart';
import 'package:how_to/Views/reset_password/components/body.dart';

class resetPassPage extends StatelessWidget {
  var logo = 'howto_logo1.png';

  resetPassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: MyAppBar(), body: Body());
  }
}
