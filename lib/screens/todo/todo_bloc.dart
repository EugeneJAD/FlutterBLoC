import 'package:flutter/cupertino.dart';
import 'package:flutter_practice/bloc/bloc.dart';
import 'package:flutter_practice/data/model/todo_model.dart';
import 'package:flutter_practice/data/repository/todo_repository.dart';
import 'dart:async';
import 'dart:developer' as developer;

class TodoBloc extends Bloc {
  final TodoRepository _repository;
  TodoBloc(this._repository);

  final _todoStreamController = StreamController<TodoState>();
  Stream<TodoState> get todoStream => _todoStreamController.stream;

  void loadTodoList() {
    _todoStreamController.sink.add(TodoState._loading());
    _fetchTodoList(false);
  }

  refresh() {
    _fetchTodoList(true);
  }

  _fetchTodoList(bool forceUpdate) {
    _repository.loadAllTodo(forceUpdate: forceUpdate).then((results) {
      _todoStreamController.sink.add(TodoState._dataLoaded(results));
    }).catchError((error) async {
      developer.log(error.toString(), name: 'TodoBloc error');
      _todoStreamController.sink.add(TodoState._error('Failed to load data.'));
    });
  }

  @override
  void dispose() {
    developer.log('dispose', name: 'TodoBloc info');
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
