import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'my_camera.dart';
import 'my_counter.dart';
import 'my_database.dart';
import 'my_geoloc.dart';
import 'my_gyroscope.dart';
import 'my_home_page.dart';
import 'my_webservice.dart';
import 'my_webservice_isolate.dart';

import 'my_notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  initNotifications();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      //home: MyCounter(title: 'Mon compteur'),
      //home: MyDatabase(),
      //home: MyNotifications(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mon appli'),
        ),
        body:
            //MyCamera(),
            //MyGyroscope(),
            //MyGeoloc(),
            MyWebService(),
        //MyWebServiceIsolate(),
      ),
    );
  }
}
