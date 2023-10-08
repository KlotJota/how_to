import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:how_to/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:how_to/Views/face_detector/screen_mode.dart';

class CameraPage extends StatefulWidget {
  final CustomPaint? customPaint;
  final String? title;
  final String? text;
  final Function(InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;

  const CameraPage({
    Key? key,
    required this.title,
    required this.onImage,
    required this.initialDirection,
    this.customPaint,
    this.text,
  }) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  ScreenMode mode = ScreenMode.live;
  CameraController? cameraController;
  File? image;
  String? path;
  ImagePicker? imagePicker;
  int cameraIndex = 0;
  double zoomLevel = 10.0, minZoomLevel = 0.1, maxZoomLevel = 0.9;
  final bool allowPicker = true;
  bool changingCameraLens = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ImagePicker imagePicker = ImagePicker();
    if (cameras.any((element) =>
        element.lensDirection == widget.initialDirection &&
        element.sensorOrientation == 90)) {
      cameraIndex = cameras.indexOf(cameras.firstWhere((element) =>
          element.lensDirection == widget.initialDirection &&
          element.sensorOrientation == 90));
    } else {
      cameraIndex = cameras.indexOf(cameras.firstWhere(
          (element) => element.lensDirection == widget.initialDirection));
    }

    startLive();
  }

  Future startLive() async {
    final camera = cameras[cameraIndex];
    cameraController =
        CameraController(camera, ResolutionPreset.high, enableAudio: false);
    cameraController?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      cameraController?.getMaxZoomLevel().then((value) {
        maxZoomLevel = value;
        minZoomLevel = value;
      });
      cameraController?.startImageStream(processCameraImage);
      setState(() {});
    });
  }

  Future<void> processCameraImage(CameraImage image) async {
    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());
    final InputImageRotation imageRotation =
        InputImageRotationValue.fromRawValue(
                cameraController!.description.sensorOrientation) ??
            InputImageRotation.rotation0deg;

    final InputImageFormat inputImageFormat =
        InputImageFormatValue.fromRawValue(image.format.raw) ??
            InputImageFormat.nv21;

    final InputImage inputImage = InputImage.fromBytes(
      bytes: _concatenatePlanes(image.planes),
      metadata: InputImageMetadata(
        size: imageSize,
        rotation: imageRotation,
        format: inputImageFormat,
        bytesPerRow:
            image.planes[0].bytesPerRow, // Usando bytesPerRow do primeiro plano
      ),
    );

    widget.onImage(inputImage);
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toString()),
        actions: [
          if (allowPicker)
            Padding(
                padding: EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: switchScreenMode,
                  child: Icon(mode == ScreenMode.live
                      ? Icons.photo_library_outlined
                      : Icons.camera_alt_outlined),
                )),
        ],
      ),
      body: body(),
      floatingActionButton: floatingInputActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget? floatingInputActionButton() {
    if (mode == ScreenMode.gallery) return null;
    if (cameras.length == 1) return null;
    return SizedBox(
      height: 70,
      width: 70,
      child: FloatingActionButton(
          onPressed: switchCamera,
          child: Icon(
            Icons.flip_camera_android,
            size: 40,
          )),
    );
  }

  Future switchCamera() async {
    setState(() {
      changingCameraLens = true;
    });
    cameraIndex = (cameraIndex + 1) % cameras.length;
    await stopLive();
    await startLive();
    setState(() {
      changingCameraLens = false;
    });
  }

  Widget galleryBody() => ListView(
        shrinkWrap: true,
        children: [
          image == null
              ? SizedBox(
                  width: 400,
                  height: 400,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(image!),
                      if (widget.customPaint != null) widget.customPaint!
                    ],
                  ),
                )
              : Icon(
                  Icons.image,
                  size: 200,
                ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                getImage(ImageSource.gallery);
              },
              child: Text('Da galeria'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                getImage(ImageSource.camera);
              },
              child: Text('Tirar uma foto'),
            ),
          ),
          if (image == null)
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                  '${path == null ? '' : 'caminho da imagem $path'}\n\n ${widget.text ?? ''}'),
            )
        ],
      );

  Future getImage(ImageSource source) async {
    setState(() {
      image = null;
      path = null;
    });
    final pickedFile = await imagePicker?.pickImage(source: source);
    if (pickedFile != null) {
      processPickedFile(pickedFile);
    }
    setState(() {});
  }

  Future processPickedFile(XFile? pickedFile) async {
    final pathFile = pickedFile?.path;
    if (pathFile == null) {
      return;
    }
    setState(() {
      image = File(pathFile);
    });
    path = pathFile;
    final inputImage = InputImage.fromFilePath(pathFile);
    widget.onImage(inputImage);
  }

  Widget body() {
    Widget body;
    if (mode == ScreenMode.live) {
      body = liveBody();
    } else {
      body = galleryBody();
    }
    return body;
  }

  Widget liveBody() {
    if (cameraController?.value.isInitialized == false) {
      return Container();
    }
    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * cameraController!.value.aspectRatio;
    if (scale < 1) scale = 1 / scale;
    return Container(
      color: Colors.black,
      child: Center(
        child: changingCameraLens
            ? Center(
                child: Text("Mudando as lentes da câmera"),
              )
            : CameraPreview(cameraController!),
      ),

      //if (widget.customPaint == null) widget.customPaint!, aqui o contorno de rosto deveria estar sendo feito
    );
  }

  void switchScreenMode() {
    image = null;
    if (mode == ScreenMode.live) {
      mode = ScreenMode.gallery;
      stopLive();
    } else {
      mode = ScreenMode.live;
      startLive();
    }
    setState(() {});
  }

  Future stopLive() async {
    await cameraController?.stopImageStream();
    await cameraController?.dispose();
    cameraController = null;
  }
}
