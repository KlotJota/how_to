import 'package:flutter/material.dart';

class LoadingSearchedTutorials extends StatelessWidget {
  const LoadingSearchedTutorials({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 105, 105, 105),
      elevation: 3,
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
      )),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 105, 105, 105),
        ),
      ),
    );
  }
}
