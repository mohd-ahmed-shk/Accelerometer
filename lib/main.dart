import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:random/ui/sensor/accelerometer_page.dart';

void main()  {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const AccelerometerPage(),
    );
  }
}