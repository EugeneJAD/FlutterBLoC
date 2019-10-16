
import 'package:flutter_practice/data/model/photo.dart';
import 'package:flutter_practice/data/remote/JsonPlaceholderApiClient.dart';

class PhotoRepository {
  final JsonPlaceholderApiClient apiClient = JsonPlaceholderApiClient();

  List<Photo> _cachedList;

  Future<List<Photo>> loadPhotos({bool forceUpdate = false}) async {
    if(_cachedList == null || forceUpdate) {
      _cachedList = await apiClient.loadPhotos();
    }
    return _cachedList;
  }
}