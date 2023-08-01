import 'package:flutter/material.dart';
import 'package:how_to/Views/profile/components/profile.menu.dart';
import 'package:how_to/Views/profile/components/profile_info.dart';

class EmptyFavorites extends StatefulWidget {
  const EmptyFavorites({super.key});

  @override
  State<EmptyFavorites> createState() => _EmptyFavoritesState();
}

class _EmptyFavoritesState extends State<EmptyFavorites> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 8,
              blurRadius: 10,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ], color: const Color.fromARGB(255, 243, 243, 243)),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: const [
              Card(
                shadowColor: Colors.black,
                margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                color: Color.fromARGB(255, 250, 247, 247),
                elevation: 5,
                child: Column(
                  children: [ProfileInfo(), ProfileMenu()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
