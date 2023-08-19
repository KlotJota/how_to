import 'package:flutter/material.dart';
import 'package:how_to/Views/appBar/appBar_home.dart';
import 'package:how_to/Views/appBar/appBar_profile.dart';
import 'package:how_to/Views/appBar/micButton.dart';
import 'package:how_to/Views/home/components/body.dart';

import '../profile/components/drawerMenu_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBarProfile(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: MicButton(),
        endDrawer: Drawer(
          child: DrawerMenuContent(),
        ),
        body: Body());
  }
}
