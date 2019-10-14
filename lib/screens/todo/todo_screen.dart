import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/data/model/todomodel.dart';
import 'package:flutter_practice/data/repository/todo_repository.dart';
import 'package:flutter_practice/screens/todo/todo_bloc.dart';
import 'package:flutter_practice/screens/todo/widgets/todo_list_item.dart';

class TodoPage extends StatefulWidget {
  TodoPage(this._repository);
  final TodoRepository _repository;

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TodoBloc _todoBloc;

  @override
  void initState() {
    _todoBloc = TodoBloc(widget._repository);
    _todoBloc.loadTodoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text('Todo list'),
          centerTitle: true,
        ),
        body: SafeArea(
            child: StreamBuilder<TodoState>(
          stream: _todoBloc.todos,
          builder: (context, snapshot) {
            if (snapshot.data is TodoDataLoaded) {
              return _buildList((snapshot.data as TodoDataLoaded).todos);
            } else if (snapshot.data is TodoError) {
              return _buildError((snapshot.data as TodoError).message);
            } else
              return _buildLoading();
          },
        )));
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
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        itemCount: todos.length,
        itemBuilder: (context, position) {
          return TodoListItem(todos[position]);
        });
  }

  @override
  void dispose() {
    _todoBloc.dispose();
    super.dispose();
  }
}
