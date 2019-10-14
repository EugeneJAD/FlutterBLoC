import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/data/repository/todo_repository.dart';
import 'package:flutter_practice/screens/todo/todo_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _repository = TodoRepository();
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;

    return Scaffold(
        body: TodoPage(_repository),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.cyan,
          unselectedItemColor:  Colors.grey,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle),
              title: Text('Todo'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image),
              title: Text('Photos'),
            )
          ],
        ));
  }
}
