import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePanel extends StatefulWidget {
  @override
  State<ProfilePanel> createState() => _ProfilePanelState();
}

class _ProfilePanelState extends State<ProfilePanel> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String user =
      'https://firebasestorage.googleapis.com/v0/b/howto-60459.appspot.com/o/perfis%2Fpadr%C3%A3o%2Fuser.png?alt=media&token=bb4a0f5c-8839-400d-8fb3-dbaaf07b3117';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: auth.currentUser!.photoURL == null
                      ? CircleAvatar(backgroundImage: NetworkImage(user))
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                              auth.currentUser!.photoURL.toString()),
                        )),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10, bottom: 2),
                      child: Text(
                        'Bem vindo!',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10),
                        child: auth.currentUser!.displayName == null
                            ? Text('Usuário')
                            : Text(auth.currentUser!.displayName.toString(),
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
