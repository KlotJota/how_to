import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:flutter/material.dart';
import 'package:how_to/Views/face_detector/camera_page.dart';
import 'package:how_to/Views/face_detector/face_detector_painter.dart';

class FaceDetectorPage extends StatefulWidget {
  const FaceDetectorPage({super.key});

  @override
  State<FaceDetectorPage> createState() => _FaceDetectorPageState();
}

class _FaceDetectorPageState extends State<FaceDetectorPage> {
  final FaceDetector faceDetector = FaceDetector(
      options: FaceDetectorOptions(
          enableContours: true, enableClassification: true));

  bool canProcess = true;
  bool isBusy = false;
  CustomPaint? customPaint;
  String? _text;

  @override
  void dispose() {
    // TODO: implement dispose
    canProcess = false;
    faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraPage(
      title: 'Detector de face',
      customPaint: customPaint,
      text: _text,
      onImage: (inputImage) {
        processImage(inputImage);
      },
      initialDirection: CameraLensDirection.front,
    );
  }

  Future<void> processImage(final InputImage inputImage) async {
    if (!canProcess) return;
    if (isBusy) return;
    isBusy = true;
    setState(() {
      _text = '';
    });

    final faces = await faceDetector.processImage(inputImage);

    final metadata = inputImage.metadata;
    if (metadata != null) {
      final painter = FaceDetectorPainter(
          faces, inputImage.metadata!.size, inputImage.metadata!.rotation);
      customPaint = CustomPaint(
        painter: painter,
      );
    } else {
      String text = 'Rostos encontrados: ${faces.length}\n\n';
      for (final face in faces) {
        text = 'rosto: ${face.boundingBox}\n\n';
      }
      _text = text;
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
