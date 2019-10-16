import 'package:flutter_practice/data/model/todo_model.dart';
import 'package:flutter_practice/data/remote/JsonPlaceholderApiClient.dart';

class TodoRepository {
  final JsonPlaceholderApiClient apiClient = JsonPlaceholderApiClient();

  List<TodoModel> _cachedList;

  Future<List<TodoModel>> loadAllTodo({bool forceUpdate = false}) async {
    if(_cachedList == null || forceUpdate) {
      _cachedList = await apiClient.loadAllTodo();
    }
    return _cachedList;
  }
}
