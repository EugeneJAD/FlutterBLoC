import 'dart:io';

import 'package:flutter_practice/data/model/photo.dart';
import 'package:flutter_practice/data/model/todo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JsonPlaceholderApiClient {
  static const _authority = 'jsonplaceholder.typicode.com';
  static const _baseUrl = 'https://$_authority';

  Future<List<TodoModel>> loadAllTodo() async {
    var response = await http.get('$_baseUrl/todos',
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return new Future.sync(() {
        //Future.sync() makes your code resilient against uncaught exceptions
        return json
            .decode(response.body)
            .map<TodoModel>((todoJson) => TodoModel.fromJson(todoJson))
            .toList();
      });
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load data.');
    }
  }

  Future<List<Photo>> loadPhotos() async {
    var albumId = '1';
    var queryParameters = {'albumId': albumId};
    var uri = Uri.https(_authority, "/photos", queryParameters);
    var response = await http.get(uri,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return new Future.sync(() {
        //Future.sync() makes your code resilient against uncaught exceptions
        return json
            .decode(response.body)
            .map<Photo>((photoJson) => Photo.fromJson(photoJson))
            .toList();
      });
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load data.');
    }
  }
}
