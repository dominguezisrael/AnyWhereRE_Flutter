// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CharacterModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterModel _$CharacterModelFromJson(Map<String, dynamic> json) =>
    CharacterModel(
      Result: json['Result'] as String,
      Text: json['Text'] as String,
      Icon: CharacterIcon.fromJson(json['Icon'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CharacterModelToJson(CharacterModel instance) =>
    <String, dynamic>{
      'Result': instance.Result,
      'Text': instance.Text,
      'Icon': instance.Icon,
    };

CharacterIcon _$CharacterIconFromJson(Map<String, dynamic> json) =>
    CharacterIcon(
      URL: json['URL'] as String,
    );

Map<String, dynamic> _$CharacterIconToJson(CharacterIcon instance) =>
    <String, dynamic>{
      'URL': instance.URL,
    };
