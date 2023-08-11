import 'package:anywherers_code_exercise/app/app_config.dart';
import 'package:anywherers_code_exercise/assets/constants.dart';
import 'package:anywherers_code_exercise/service/CharactersService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../model/CharacterModel.dart';

class LoadingDataWidget extends StatefulWidget {
  const LoadingDataWidget({super.key});

  @override
  State<LoadingDataWidget> createState() => _LoadingDataWidgetState();
}

class _LoadingDataWidgetState extends State<LoadingDataWidget> {
  late List<CharacterModel> characterModels;
  String message = "Loading data...";

  @override
  void initState() {
    super.initState();

    displayTvShowCharacters();
  }

  @override
  Widget build(BuildContext context) {
    AppConfig.setIsTablet(context);

    return Scaffold(
        backgroundColor: AppConfig.tvShow == TvShow.simpsons
            ? Colors.yellow
            : Colors.grey[600],
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: SpinKitFoldingCube(color: Colors.white, size: 80.0),
              ),
              const SizedBox(
                height: 60.0,
              ),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
  }

  void displayTvShowCharacters() async {
    try {
      characterModels = await CharactersService.requestTvShowCharacters();
    } catch (e) {
      setState(() {
        message = e.toString();
      });

      return;
    }

    if (!context.mounted) return;

    if (AppConfig.isTablet()) {
      Navigator.of(context).pushReplacementNamed(
          Routes.charactersAndDetail.name,
          arguments: {charactersListArgument: characterModels});
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.characters.name,
          arguments: {charactersListArgument: characterModels});
    }
  }

// Future<void> requestData() async {
//   String requestErrorMessage =
//       "An error occurred while retrieving characters";
//
//   try {
//     Response response = await Dio().get(
//         "https://api.duckaduckgo.com/?q=${AppConfig.tvShow?.name}&format=json");
//
//     if (response.statusCode == 200) {
//       Map data = jsonDecode(response.data);
//
//       Map<String, dynamic> jsonData = {
//         "RelatedTopics": data["RelatedTopics"]
//       };
//
//       CharacterListModel characterModelList =
//           CharacterListModel.fromJson(jsonData);
//
//       characterModels = characterModelList.RelatedTopics.map(
//           (e) => CharacterModel.fromJson(e)).toList();
//     } else {
//       setState(() {
//         message = requestErrorMessage;
//       });
//     }
//   } catch (e) {
//     setState(() {
//       message = requestErrorMessage;
//     });
//   }
// }
}
