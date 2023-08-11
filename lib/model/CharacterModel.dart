import 'package:json_annotation/json_annotation.dart';

part 'CharacterModel.g.dart';

@JsonSerializable()
class CharacterModel {
  String Result;
  String Text;
  CharacterIcon Icon;

  CharacterModel(
      {required this.Result, required this.Text, required this.Icon});

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);

  String getName() {
    return Text.split("-")[0].trim();
  }
}

@JsonSerializable()
class CharacterIcon {
  String URL;

  CharacterIcon({required this.URL});

  factory CharacterIcon.fromJson(Map<String, dynamic> json) =>
      _$CharacterIconFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterIconToJson(this);

  String getUrl() {
    return "https://duckduckgo.com$URL";
  }
}
