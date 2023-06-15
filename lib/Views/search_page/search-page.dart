import 'package:flutter/material.dart';
import 'package:how_to/Views/search_page/components/body.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body());
  }
}
