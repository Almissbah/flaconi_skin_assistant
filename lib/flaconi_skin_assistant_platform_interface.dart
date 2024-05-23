import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flaconi_skin_assistant_method_channel.dart';

abstract class FlaconiSkinAssistantPlatform extends PlatformInterface {
  /// Constructs a FlaconiSkinAssistantPlatform.
  FlaconiSkinAssistantPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlaconiSkinAssistantPlatform _instance = MethodChannelFlaconiSkinAssistant();

  /// The default instance of [FlaconiSkinAssistantPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlaconiSkinAssistant].
  static FlaconiSkinAssistantPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlaconiSkinAssistantPlatform] when
  /// they register themselves.
  static set instance(FlaconiSkinAssistantPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
