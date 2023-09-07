import 'package:flutter/material.dart';

class SearchSingleton {
  static final SearchSingleton controller = SearchSingleton._internal();

  final TextEditingController _searchController = TextEditingController();

  factory SearchSingleton() {
    return controller;
  }

  SearchSingleton._internal();

  TextEditingController get searchController => _searchController;
}
