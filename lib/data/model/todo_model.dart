import 'package:json_annotation/json_annotation.dart';
part 'generated/todo_model.g.dart';

@JsonSerializable()
class TodoModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'completed')
  bool completed;

  TodoModel({this.id, this.title, this.completed = false});

  factory TodoModel.fromJson(Map<String, dynamic> json) => _$TodoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}