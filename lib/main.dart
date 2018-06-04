import 'package:flutter/material.dart';
import 'package:startup_william/RandomWords.dart'; // Add this line.

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'William - Flutter Test',
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: new RandomWords(),
    );
  }
}

void main() => runApp(new MyApp());