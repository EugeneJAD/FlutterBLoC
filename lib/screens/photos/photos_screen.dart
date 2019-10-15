
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PhotosPage extends StatefulWidget {
  PhotosPage({Key key}): super(key: key);

  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text('Photos'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Center(
          child: Text("Photos content"),
        )));
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError(String error) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(error),
        ));
  }
}
