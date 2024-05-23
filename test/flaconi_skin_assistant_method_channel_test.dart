import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flaconi_skin_assistant/flaconi_skin_assistant_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFlaconiSkinAssistant platform = MethodChannelFlaconiSkinAssistant();
  const MethodChannel channel = MethodChannel('flaconi_skin_assistant');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
