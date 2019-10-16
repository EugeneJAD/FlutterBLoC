import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/data/model/todo_model.dart';
import 'package:flutter_practice/screens/todo/details/todo_details_screen.dart';

class TodoListItem extends StatefulWidget {
  TodoListItem(this._todoModel);
  final TodoModel _todoModel;

  @override
  State<StatefulWidget> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
            onTap: () {
              _navigateToDetails();
            },
            trailing: IconButton(
                icon: Icon(
                  widget._todoModel.completed
                      ? Icons.check_circle
                      : Icons.check_circle_outline,
                  color:
                      widget._todoModel.completed ? Colors.green : Colors.grey,
                  size: 36.0,
                ),
                onPressed: _onIconClick),
            title: Text(
              widget._todoModel.title,
              style: Theme.of(context).textTheme.body1,
            )));
  }

  void _onIconClick() {
    setState(() {
      widget._todoModel.completed = !widget._todoModel.completed;
    });
  }

  _navigateToDetails() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TodoDetailsPage(widget._todoModel),
        ));
  }
}
