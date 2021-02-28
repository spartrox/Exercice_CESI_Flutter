import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyGeoloc extends StatefulWidget {
  @override
  _MyGeolocState createState() => _MyGeolocState();
}

class _MyGeolocState extends State<MyGeoloc> {
  Future<void> _initGeolocFuture;

  @override
  void initState() {
    super.initState();
    _initGeolocFuture = _checkPermissionsFuture();
  }

  Future<void> _checkPermissionsFuture() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initGeolocFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder<Position>(
              stream: Geolocator.getPositionStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var position = snapshot.data;
                  return Text(position.toString());
                }
                return Center(child: CircularProgressIndicator());
              });
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
