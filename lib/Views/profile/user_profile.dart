import 'package:flutter/material.dart';
import 'package:how_to/Views/appBar/micButton.dart';

import 'package:how_to/Views/profile/components/body.dart';
import 'package:how_to/Views/profile/components/drawerMenu_content.dart';

import '../appBar/appBar_profile.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  void _openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBarProfile(),
        endDrawer: Drawer(
          child: DrawerMenuContent(),
        ),
        body: Body());
  }
}
