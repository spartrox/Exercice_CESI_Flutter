import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'user.dart';

class MyDatabase extends StatefulWidget {
  @override
  _MyDatabaseState createState() => _MyDatabaseState();
}

class _MyDatabaseState extends State<MyDatabase> {
  Database _db;
  int _counter = 0;

  @override
  void dispose() {
    _db?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Database'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Utilisateurs :',
            ),
            _usersList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _insertUser,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  void _insertUser() async {
    ++_counter;
    var user = User(
        id: _counter,
        name: 'User$_counter',
        email: 'user$_counter@company.com');
    await _db.insert('users', user.toMap());
    setState(() {});
  }

  Widget _usersList() {
    return FutureBuilder<List<User>>(
      future: _getUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Text(snapshot.data.join('\n'));
          } else {
            return Text("Erreur");
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<List<User>> _getUsers() async {
    await _initDBIfNeeded();
    var maps = await _db.query('users');
    _counter = maps.length;

    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
      );
    });
  }

  Future<void> _initDBIfNeeded() async {
    if (_db == null) {
      _db = await openDatabase('ma_bdd.db', version: 1,
          onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE Users (id INTEGER PRIMARY KEY, name TEXT, email TEXT)');
      });
    }
  }
}
