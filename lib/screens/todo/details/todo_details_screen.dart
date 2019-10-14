import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/data/model/todomodel.dart';

class TodoDetailsPage extends StatefulWidget {
  final TodoModel _todoModel;

  TodoDetailsPage(this._todoModel) : assert(_todoModel != null);

  @override
  State<StatefulWidget> createState() =>
      _TodoDetailsPageState(todoModel: _todoModel);
}

class _TodoDetailsPageState extends State<TodoDetailsPage> {
  final TodoModel todoModel;
  bool _completed;
  String _title;
  final textController = TextEditingController();

  _TodoDetailsPageState({this.todoModel});

  @override
  void initState() {
    super.initState();
    _completed = todoModel.completed;
    _title = todoModel.title;
    textController.text = todoModel.title;
    textController.addListener(_onTextChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Todo details'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text("Save",
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Colors.white)),
            onPressed: () {
              _onSavePressed();
            },
          )
        ],
      ),
      body: SafeArea(
          child: Column(children: <Widget>[
        Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
                decoration: InputDecoration(
                    labelText: 'Task name', hintText: 'Enter task name'),
                controller: textController)),
        RaisedButton.icon(
          color: Colors.cyan,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          onPressed: () {
            setState(() {
              _completed = !_completed;
            });
          },
          icon: Icon(
            _completed ? Icons.check_circle : Icons.check_circle_outline,
            color: Colors.white,
          ),
          label: Text(
            _completed ? 'Mark as uncompleted' : 'Mark as complete',
            style: Theme.of(context).textTheme.button,
          ),
        )
      ])),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    textController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    _title = textController.text;
  }

  void _onSavePressed() {
    todoModel.title = _title;
    todoModel.completed = _completed;
    Navigator.pop(context);
  }
}
