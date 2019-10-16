
import 'dart:async';
import 'package:flutter_practice/bloc/bloc.dart';
import 'package:flutter_practice/data/model/photo.dart';
import 'package:flutter_practice/data/repository/photo_repository.dart';
import 'dart:developer' as developer;

class PhotosBloc extends Bloc {

  final PhotoRepository _repository;
  PhotosBloc(this._repository);

  final _streamController = StreamController<PhotosState>();
  Stream<PhotosState> get photosStream => _streamController.stream;

  loadPhotos() {
    _streamController.sink.add(PhotosState._loading());
    _fetchPhotos(false);
  }

  _fetchPhotos(bool forceUpdate) {
    _repository.loadPhotos(forceUpdate: forceUpdate).then((results) {
      _streamController.sink.add(PhotosState._dataLoaded(results));
    }).catchError((error) async {
      developer.log(error.toString(), name: 'PhotosBloc error');
      _streamController.sink.add(PhotosState._error('Failed to load data.'));
    });
  }

  @override
  void dispose() {
    _streamController.close();
  }
}

class PhotosState {
  PhotosState();
  factory PhotosState._loading() = Loading;
  factory PhotosState._dataLoaded(List<Photo> photos) = DataLoaded;
  factory PhotosState._error(String message) = Error;
}

class DataLoaded extends PhotosState {
  final List<Photo> photos;
  DataLoaded(this.photos);
}

class Error extends PhotosState {
  final String message;
  Error(this.message);
}

class Loading extends PhotosState {}