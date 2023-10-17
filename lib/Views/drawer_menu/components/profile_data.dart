import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:how_to/Views/acessibility/acessibility_singleton.dart';

class ProfileData extends StatefulWidget {
  const ProfileData({super.key});

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData>
    with SingleTickerProviderStateMixin {
  FirebaseAuth auth = FirebaseAuth.instance;

  String user =
      'https://firebasestorage.googleapis.com/v0/b/howto-60459.appspot.com/o/perfis%2Fpadr%C3%A3o%2Fuser.png?alt=media&token=bb4a0f5c-8839-400d-8fb3-dbaaf07b3117';
  late AnimationController _controller;

  bool isAccessibilityEnabled = AccessibilitySettings().isAccessibilityEnabled;
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    initializeTts();
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
      }
    });

    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    flutterTts.stop();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward();
  }

  Future<void> initializeTts() async {
    await flutterTts.setLanguage("pt-BR");
    await flutterTts.setPitch(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String userName = auth.currentUser!.displayName.toString();

        if (!auth.currentUser!.isAnonymous) {
          isAccessibilityEnabled ? flutterTts.speak('Olá $userName') : null;
        }
      },
      child: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        color: const Color.fromRGBO(0, 9, 89, 1),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: const Color.fromARGB(255, 250, 247, 247)),
              ),
              margin: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: _startAnimation,
                child: RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                    child: auth.currentUser!.photoURL == null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(user),
                            radius: 50,
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(
                              auth.currentUser!.photoURL.toString(),
                            ),
                            radius: 50)),
              ),
            ),
            Text('olá,',
                style: TextStyle(
                    color: Color.fromARGB(255, 250, 250, 250),
                    overflow: TextOverflow.ellipsis,
                    fontSize: isAccessibilityEnabled ? 15 : 10)),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: auth.currentUser!.isAnonymous
                  ? Text('Usuário',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 250, 250, 250),
                        overflow: TextOverflow.ellipsis,
                        fontSize: 20,
                      ))
                  : Text(auth.currentUser!.displayName.toString(),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 250, 250, 250),
                        overflow: TextOverflow.ellipsis,
                        fontSize: 20,
                      )),
            ),
            auth.currentUser!.isAnonymous
                ? Container()
                : Text(
                    auth.currentUser!.email.toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 250, 250, 250),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
