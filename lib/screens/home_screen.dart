import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/data/repository/photo_repository.dart';
import 'package:flutter_practice/data/repository/todo_repository.dart';
import 'package:flutter_practice/screens/photos/photos_screen.dart';
import 'package:flutter_practice/screens/todo/todo_screen.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _todoPage = TodoPage(key: PageStorageKey('Todo_Page'), repository: TodoRepository());
  final _photosPage = PhotosPage(key: PageStorageKey('Photos_Page'), repository: PhotoRepository());
  final PageStorageBucket bucket = PageStorageBucket();
  List<Widget> _pages;
  int _currentIndex = 0;

  @override
  void initState() {
    _pages = <Widget>[_todoPage, _photosPage];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageStorage(
          child: _pages[_currentIndex],
          bucket: bucket,
        ),
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
          onTap: _onItemTapped,
        ));
  }

  _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
