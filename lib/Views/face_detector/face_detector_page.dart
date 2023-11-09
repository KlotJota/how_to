import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:how_to/Views/acessibility/flutterTts_singleton.dart';

import 'package:how_to/Views/face_detector/camera_page.dart';
import 'package:how_to/Views/face_detector/face_detector_painter.dart';

class FaceDetectorPage extends StatefulWidget {
  final String tutorialId;
  FaceDetectorPage(this.tutorialId, {super.key});
  @override
  State<FaceDetectorPage> createState() => _FaceDetectorPageState();
}

class _FaceDetectorPageState extends State<FaceDetectorPage> {
  final FlutterTts flutterTts = FlutterTts();
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
    ),
  );
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;

  String? tutorialText;

  bool isReading = false;
  List<String> textToReadList = [];

  var _cameraLensDirection = CameraLensDirection.front;

  @override
  void initState() {
    super.initState();
    initializeTts();
    buscarTutorial(widget.tutorialId);
    // currentIndex = 0;
  }

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    flutterTts.stop();
    super.dispose();
  }

  Future<void> initializeTts() async {
    await flutterTts.setLanguage("pt-BR");
    await flutterTts.setPitch(1.0);
    await buscarTutorial(widget.tutorialId);
  }

  Future<void> buscarTutorial(String id) async {
    final tutorialDoc =
        await FirebaseFirestore.instance.collection('tutoriais').doc(id).get();

    if (tutorialDoc.exists) {
      setState(() {
        tutorialText =
            tutorialDoc['titulo'] + '.' + tutorialDoc['texto'] as String;
        textToReadList.addAll(tutorialText!.split(RegExp(r'[,.]')));
        print(textToReadList);
      });
    } else {
      print('Documento não encontrado');
    }
  }

  Future<void> speakCurrentPart() async {
    await flutterTts.awaitSpeakCompletion(true);
    flutterTts.speak('Este é o tutorial: ' + tutorialText!);
  }

  @override
  Widget build(BuildContext context) {
    return DetectorView(
      title: 'Face Detector',
      customPaint: _customPaint,
      onImage: _processImage,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;

    final faces = await _faceDetector.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      _customPaint = null;
    }

    if (faces.isNotEmpty) {
      speakCurrentPart();
      // delay para nao bugar a fala do narrador
      await Future.delayed(Duration(seconds: 2));
    } else {
      await flutterTts.stop();
    }

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
