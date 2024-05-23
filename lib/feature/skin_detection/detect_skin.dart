import 'package:flaconi_skin_assistant/feature/skin_detection/camera_screen.dart';
import 'package:flutter/material.dart';

class DetectSkin extends StatelessWidget {
  const DetectSkin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Click below to start skin detection'),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CameraScreen()));
            },
            child: const Text('Start'))
      ],
    );
  }
}
