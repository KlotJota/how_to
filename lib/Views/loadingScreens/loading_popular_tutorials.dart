import 'package:flutter/material.dart';

class LoadingPopularTutorials extends StatelessWidget {
  const LoadingPopularTutorials({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 105, 105, 105),
      elevation: 3,
      margin: const EdgeInsets.only(left: 5, right: 5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15))),
      child: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 105, 105, 105)),
        width: 160,
      ),
    );
  }
}
