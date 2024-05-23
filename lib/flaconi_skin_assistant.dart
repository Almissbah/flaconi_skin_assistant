library skin_assistant;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

export 'package:flaconi_skin_assistant/feature/skin_detection/detect_skin.dart';

late List<CameraDescription> cameras;

class FlaconiAssistant {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  }
}
