import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'views/app.dart'; // toda classe que criarmos precisa sem importada aqui

const firebaseConfig = FirebaseOptions(
  apiKey: "AIzaSyBsCEO5On4mjgZp7rzggN4e1qGFYJExcpg",
  authDomain: "howto-60459.firebaseapp.com",
  projectId: "howto-60459",
  storageBucket: "howto-60459.appspot.com",
  messagingSenderId: "535942903793",
  appId: "1:535942903793:web:f6912525d25b6c2245f650",
  measurementId: "G-7GM0XSZFEC",
);

void main() async {
  // garante que o app será carregado apenas quando a conexão estiver sido feita
  WidgetsFlutterBinding.ensureInitialized();

  // aguarda a inicialização do firebase para executar a ação seguinte:
  await Firebase.initializeApp(options: firebaseConfig);
  runApp(App());
}
