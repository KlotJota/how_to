import 'package:flutter/material.dart';

import 'package:how_to/Views/search_page/components/body.dart';

import '../appBar/appBar_profile.dart';
import '../appBar/micButton.dart';
import '../profile/components/drawerMenu_content.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBarProfile(),
        floatingActionButton: MicButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        endDrawer: Drawer(
          child: DrawerMenuContent(),
        ),
        body: Body());
  }
}
