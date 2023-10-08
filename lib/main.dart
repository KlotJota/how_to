import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'views/app.dart'; // toda classe que criarmos precisa sem importada aqui
import 'package:get_storage/get_storage.dart';

const firebaseConfig = FirebaseOptions(
  apiKey: "AIzaSyBsCEO5On4mjgZp7rzggN4e1qGFYJExcpg",
  authDomain: "howto-60459.firebaseapp.com",
  projectId: "howto-60459",
  storageBucket: "howto-60459.appspot.com",
  messagingSenderId: "535942903793",
  appId: "1:535942903793:web:f6912525d25b6c2245f650",
  measurementId: "G-7GM0XSZFEC",
);

List<CameraDescription> cameras = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await GetStorage.init();
  // garante que o app será carregado apenas quando a conexão estiver sido feita
  WidgetsFlutterBinding.ensureInitialized();

  // aguarda a inicialização do firebase para executar a ação seguinte:
  await Firebase.initializeApp(options: firebaseConfig);
  runApp(App());
}
