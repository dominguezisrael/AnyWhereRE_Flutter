import 'package:json_annotation/json_annotation.dart';

part 'CharacterListModel.g.dart';

@JsonSerializable()
class CharacterListModel {
  List<dynamic> RelatedTopics;

  CharacterListModel({required this.RelatedTopics});

  factory CharacterListModel.fromJson(Map<String, dynamic> json) {
    return _$CharacterListModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CharacterListModelToJson(this);
}
