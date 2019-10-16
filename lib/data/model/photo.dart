import 'package:json_annotation/json_annotation.dart';
part 'generated/photo.g.dart';

@JsonSerializable()
class Photo {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'albumId')
  final int albumId;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'url')
  String url;
  @JsonKey(name: 'thumbnailUrl')
  String thumbnail;

  Photo({this.id, this.albumId, this.title, this.url, this.thumbnail});

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}