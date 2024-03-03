import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerPage extends StatefulWidget {
  const AccelerometerPage({super.key});

  @override
  State<AccelerometerPage> createState() => _AccelerometerPageState();
}

class _AccelerometerPageState extends State<AccelerometerPage> {
  AccelerometerEvent? _accelerometerValues;
  late StreamSubscription<dynamic> _accelerometerSubscription;

  double accelerationThreshold = 12.0;
  double brakingThreshold = -12.0;

  @override
  void initState() {
    super.initState();
    _accelerometerSubscription = accelerometerEventStream().listen(
      (AccelerometerEvent event) {
        setState(() {
          _accelerometerValues = event;

          if (_accelerometerValues!.x > accelerationThreshold ||
              _accelerometerValues!.y > accelerationThreshold ||
              _accelerometerValues!.z > accelerationThreshold) {
            notifyUser("Harsh Acceleration Detected!");
          }

          if (_accelerometerValues!.x < brakingThreshold ||
              _accelerometerValues!.y < brakingThreshold ||
              _accelerometerValues!.z < brakingThreshold) {
            notifyUser("Harsh Braking Detected!");
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    super.dispose();
  }

  void notifyUser(String message) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Alert!',
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 50),
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 15),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accelerometer App'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.speed,
                color: Colors.red,
                size: 50,
              ),
              const Text(
                'Accelerometer Values:',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 20),
              _accelerometerValues != null
                  ? Text(
                      'X: ${_accelerometerValues!.x}\nY: ${_accelerometerValues!.y}\nZ: ${_accelerometerValues!.z}',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    )
                  : const Text('Waiting for data...'),
            ],
          ),
        ),
      ),
    );
  }
}
