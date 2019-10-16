import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_practice/bloc/bloc_provider.dart';
import 'package:flutter_practice/data/model/photo.dart';
import 'package:flutter_practice/data/repository/photo_repository.dart';
import 'package:flutter_practice/screens/photos/photos_bloc.dart';

class PhotosPage extends StatefulWidget {
  final PhotoRepository repository;

  PhotosPage({Key key, this.repository}) : super(key: key);

  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  PhotosBloc bloc;

  @override
  void initState() {
    bloc = PhotosBloc(widget.repository);
    bloc.loadPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotosBloc>(
        bloc: bloc,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.cyan,
              title: Text('Photos'),
              centerTitle: true,
            ),
            body: SafeArea(
                child: StreamBuilder<PhotosState>(
              stream: bloc.photosStream,
              builder: (context, snapshot) {
                if (snapshot.data is DataLoaded) {
                  return _buildList((snapshot.data as DataLoaded).photos);
                } else if (snapshot.data is Error) {
                  return _buildError((snapshot.data as Error).message);
                } else
                  return _buildLoading();
              },
            ))));
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

  Widget _buildList(List<Photo> list) {
    return GridView.builder(
        itemCount: list.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          final photo = list[index];
          return GridTile(
              child: Stack(fit: StackFit.expand, children: <Widget>[
            Image.network(
              photo.url,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
              child: RichText(
                  maxLines: 2,
                  text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(color: Colors.white),
                      children: [TextSpan(text: photo.title)])),
            )
          ]));
        });
  }
}
