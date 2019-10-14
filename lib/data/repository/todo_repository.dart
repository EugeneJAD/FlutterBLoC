import 'package:flutter_practice/data/model/todomodel.dart';
import 'package:flutter_practice/data/remote/TodoApiClient.dart';

class TodoRepository {
  final TodoApiClient apiClient = TodoApiClient();

  Future<List<TodoModel>> loadAllTodo() => apiClient.loadAllTodo();
}
