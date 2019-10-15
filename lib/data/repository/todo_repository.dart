import 'package:flutter_practice/data/model/todomodel.dart';
import 'package:flutter_practice/data/remote/TodoApiClient.dart';

class TodoRepository {
  final TodoApiClient apiClient = TodoApiClient();

  List<TodoModel> _cachedList;

  Future<List<TodoModel>> loadAllTodo({bool forceUpdate = false}) async {
    if(_cachedList == null || forceUpdate) {
      _cachedList = await apiClient.loadAllTodo();
    }
    return _cachedList;
  }
}
