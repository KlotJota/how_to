import 'package:flutter/material.dart';

import 'package:how_to/Views/search_page/components/body.dart';

import '../appBar/appBar_profile.dart';
import '../profile/components/drawerMenu_content.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: MyAppBarProfile(),
        endDrawer: Drawer(
          child: DrawerMenuContent(),
        ),
        body: Body());
  }
}
