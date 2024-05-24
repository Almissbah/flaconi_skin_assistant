import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flaconi_skin_assistant/flaconi_skin_assistant.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  XFile? picture;
  bool scanning = false;

  @override
  void initState() {
    super.initState();

    controller = CameraController(cameras[1], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  Future takePicture() async {
    if (!controller.value.isInitialized) {
      return null;
    }
    if (controller.value.isTakingPicture) {
      return null;
    }
    try {
      await controller.setFlashMode(FlashMode.off);
      picture = await controller.takePicture();
      setState(() {});
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Haut Scanner')),
        leading: IconButton(
          icon: const Text('Back'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: (picture == null)
            ? Container(
                color: Colors.green,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CameraPreview(
                        controller,
                      ),
                    ),
                    if (scanning) OverlayWithRectangleClipping(),
                    scanning == true
                        ? Positioned(
                            bottom: 30,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: IconButton(
                                  onPressed: () {
                                    takePicture();
                                  },
                                  icon: const Icon(
                                    Icons.camera,
                                    size: 80,
                                    color: Colors.white,
                                  )),
                            ),
                          )
                        : Positioned.fill(child: TipsWidget(
                            onButtonPressed: () {
                              setState(() {
                                scanning = true;
                              });
                            },
                          )),
                  ],
                ),
              )
            : Image.file(File(picture!.path)),
      ),
    );
  }
}

class OverlayWithRectangleClipping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: _getCustomPaintOverlay(context));
  }

  //CustomPainter that helps us in doing this
  CustomPaint _getCustomPaintOverlay(BuildContext context) {
    return CustomPaint(
        size: MediaQuery.of(context).size, painter: RectanglePainter());
  }
}

class RectanglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black54;

    canvas.drawPath(
        Path.combine(
          PathOperation.difference, //simple difference of following operations
          //bellow draws a rectangle of full screen (parent) size
          Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
          //bellow clips out the circular rectangle with center as offset and dimensions you need to set
          Path()
            ..addRRect(RRect.fromRectAndRadius(
                Rect.fromCenter(
                    center: Offset(size.width * 0.5, size.height * 0.5),
                    height: size.width * .8,
                    width: size.height * 0.29),
                Radius.circular(size.width * 3)))
            ..close(),
        ),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class TipsWidget extends StatelessWidget {
  const TipsWidget({super.key, required this.onButtonPressed});
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(206, 23, 29, 29),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.only(bottom: 30.0),
            child: Text(
              'Bevor es losgeht',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const InfoRow(
            text: 'Entferne alles, was deine Haut verdecken konnte',
          ),
          const InfoRow(
            text: 'Achte auf gute Beleuchtung',
          ),
          const InfoRow(
            text: 'Binde deine haare zuruck und setze deine Brille ab',
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: FilledButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                  side: MaterialStatePropertyAll(BorderSide(width: 3)),
                ),
                onPressed: onButtonPressed,
                child: const Text(
                  'Scan Starten',
                  style: TextStyle(color: Colors.black),
                )),
          )
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Icon(
            Icons.camera,
            color: Colors.white,
          ),
        ),
        Flexible(
          child: Text(
            text,
            maxLines: 2,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}
