// controlleur et vue
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user.dart';

class MyWebService extends StatefulWidget {
  @override
  _MyWebServiceState createState() => _MyWebServiceState();
}

class _MyWebServiceState extends State<MyWebService> {
  Future<User> _fetchUser() async {
    const url = 'https://jsonplaceholder.typicode.com/users/1';
    final response = await http.get(url);
    print('status: ${response.statusCode}');
    print('body: ${response.body}');

    return _parseJson(response.body);
  }

  User _parseJson(String json) {
    final userMap = jsonDecode(json) as Map<String, dynamic>;
    return User.fromMap(userMap);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _fetchUser(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? Text(snapshot.data.email)
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
