import 'package:flutter/material.dart';

import 'package:flaconi_skin_assistant/flaconi_skin_assistant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlaconiAssistant.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: DetectSkin(),
        ),
      ),
    );
  }
}
