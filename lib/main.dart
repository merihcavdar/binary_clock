import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'widgets.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Alatsi',
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Colors.black38,
            fontSize: 30.0,
          ),
        ),
      ),
      home: const Scaffold(
        body: Clock(),
      ),
    );
  }
}
