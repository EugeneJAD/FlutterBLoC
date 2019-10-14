import 'package:flutter_practice/data/model/todomodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoRepository {
  final _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<TodoModel>> loadAllTodo() async {
    var response = await http.get('$_baseUrl/todos');
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
      throw Exception('Failed to load post');
    }
  }
}
