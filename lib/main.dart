import 'package:flutter/material.dart';
import 'package:flutter_practice/screens/home_screen.dart';
import 'package:flutter_practice/screens/todo/todo_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Practice',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.blue[800],
        accentColor: Colors.cyan,
        // Define the default font family.
        fontFamily: 'Montserrat',
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          button:TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          body2: TextStyle(fontSize: 18.0, fontFamily: 'Hind'),
        ),
      ),
      home: HomePage(),
    );
  }
}
