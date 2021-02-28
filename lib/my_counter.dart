import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCounter extends StatefulWidget {
  MyCounter({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyCounterState createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  SharedPreferences _prefs;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  void _initAsync() async {
    _prefs = await SharedPreferences.getInstance();
    _counter = _prefs.getInt('counter') ?? 0;
    if (mounted) {
      setState(() {});
    }
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await _prefs?.setInt('counter', _counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
