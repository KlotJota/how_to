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
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: const [
              Card(
                margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
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
