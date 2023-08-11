import 'dart:convert';

import 'package:anywherers_code_exercise/model/CharacterModel.dart';
import 'package:dio/dio.dart';

import '../app/app_config.dart';
import '../model/CharacterListModel.dart';

class CharactersService {
  static const String domain = 'https://api.duckduckgo.com/';

  static Future<List<CharacterModel>> requestTvShowCharacters() async {
    String requestErrorMessage =
        "An error occurred while retrieving characters";

    try {
      Response response = await Dio().get(
          "$domain?q=${AppConfig.tvShow?.name}&format=json");

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.data);

        Map<String, dynamic> jsonData = {
          "RelatedTopics": data["RelatedTopics"]
        };

        CharacterListModel characterModelList =
            CharacterListModel.fromJson(jsonData);

        return characterModelList.RelatedTopics.map(
            (e) => CharacterModel.fromJson(e)).toList();
      } else {
        throw Exception(requestErrorMessage);
      }
    } catch (e) {
      throw Exception(requestErrorMessage);
    }
  }
}
