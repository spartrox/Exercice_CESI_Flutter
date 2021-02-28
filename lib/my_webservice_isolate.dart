import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user.dart';

class MyWebServiceIsolate extends StatefulWidget {
  @override
  _MyWebServiceIsolateState createState() => _MyWebServiceIsolateState();
}

class _MyWebServiceIsolateState extends State<MyWebServiceIsolate> {
  Future<User> _fetchUser() async {
    const url = 'https://jsonplaceholder.typicode.com/users/1';
    final response = await http.get(url);
    print('status: ${response.statusCode}');
    print('body: ${response.body}');

    return compute(parseJson, response.body);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _fetchUser(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? Text(snapshot.data.name)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}

User parseJson(String json) {
  final userMap = jsonDecode(json) as Map<String, dynamic>;
  print(
      "début traitement long pour simuler un long temps de décodage d'un gros json");
  var s = '';
  for (int i = 0; i < 40000; i++) {
    s += i.toString();
  }
  print('fin traitement long $s');
  return User.fromMap(userMap);
}
