import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/bloc/bloc_provider.dart';
import 'package:flutter_practice/data/model/todo_model.dart';
import 'package:flutter_practice/data/repository/todo_repository.dart';
import 'package:flutter_practice/screens/todo/todo_bloc.dart';
import 'package:flutter_practice/screens/todo/widgets/todo_list_item.dart';

class TodoPage extends StatefulWidget {
  final TodoRepository repository;
  TodoPage({Key key, this.repository}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TodoBloc _todoBloc;
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    _todoBloc = TodoBloc(widget.repository);
    _todoBloc.loadTodoList();
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
        bloc: _todoBloc,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.cyan,
              title: Text('Todo list'),
              centerTitle: true,
            ),
            body: SafeArea(
                child: StreamBuilder<TodoState>(
              stream: _todoBloc.todoStream,
              builder: (context, snapshot) {
                if (snapshot.data is TodoDataLoaded) {
                  _refreshCompleter?.complete();
                  _refreshCompleter = Completer();
                  return _buildList((snapshot.data as TodoDataLoaded).todos);
                } else if (snapshot.data is TodoError) {
                  return _buildError((snapshot.data as TodoError).message);
                } else
                  return _buildLoading();
              },
            ))));
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError(String error) {
    return Center(
      child: Text(error),
    );
  }

  Widget _buildList(List<TodoModel> todos) {
    return RefreshIndicator(
        onRefresh: () {
          _todoBloc.refresh();
          return _refreshCompleter.future;
        },
        child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            itemCount: todos.length,
            itemBuilder: (context, position) {
              return TodoListItem(todos[position]);
            }));
  }
}
