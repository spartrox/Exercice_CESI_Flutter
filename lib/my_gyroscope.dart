import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class MyGyroscope extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GyroscopeEvent>(
      stream: gyroscopeEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var gyro = snapshot.data;
          return Text(gyro.toString());
        } else {
          return Text('Pas de données');
        }
      },
    );
  }
}
