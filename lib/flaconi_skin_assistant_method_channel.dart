import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flaconi_skin_assistant_platform_interface.dart';

/// An implementation of [FlaconiSkinAssistantPlatform] that uses method channels.
class MethodChannelFlaconiSkinAssistant extends FlaconiSkinAssistantPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flaconi_skin_assistant');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
