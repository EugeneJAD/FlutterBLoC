import 'package:flutter_practice/data/model/todomodel.dart';
import 'package:flutter_practice/data/repository/todo_repository.dart';
import 'dart:async';

class TodoBloc {
  final TodoRepository _repository;
  TodoBloc(this._repository);

  final _todoStreamController = StreamController<TodoState>();
  Stream<TodoState> get todos => _todoStreamController.stream;

  void loadTodoList() {
    _todoStreamController.sink.add(TodoState._loading());
    _repository.loadAllTodo().then((results) {
      _todoStreamController.sink.add(TodoState._dataLoaded(results));
    }).catchError((error) {
      _todoStreamController.sink.add(TodoState._error(error.toString()));
    });
  }

  void dispose() {
    _todoStreamController.close();
  }
}

class TodoState {
  TodoState();
  factory TodoState._loading() = TodoLoading;
  factory TodoState._dataLoaded(List<TodoModel> todos) = TodoDataLoaded;
  factory TodoState._error(String message) = TodoError;
}

class TodoDataLoaded extends TodoState {
  final List<TodoModel> todos;
  TodoDataLoaded(this.todos);
}

class TodoError extends TodoState {
  final String message;
  TodoError(this.message);
}

class TodoLoading extends TodoState {}
