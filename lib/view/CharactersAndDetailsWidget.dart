import 'package:flutter/material.dart';

import '../app/app_config.dart';
import '../assets/constants.dart';
import '../model/CharacterModel.dart';
import 'CharacterDetailsWidget.dart';
import 'CharactersWidget.dart';

class CharactersAndDetailsWidget extends StatefulWidget {
  final AppConfigHelper appConfigHelper;

  const CharactersAndDetailsWidget(this.appConfigHelper, {super.key});

  @override
  State<CharactersAndDetailsWidget> createState() =>
      _CharactersAndDetailsWidgetState();
}

class _CharactersAndDetailsWidgetState
    extends State<CharactersAndDetailsWidget> {
  CharacterModel? selectedCharacter;

  @override
  Widget build(BuildContext context) {
    Map<String, List<CharacterModel>> characterModelsMapArgument =
        ModalRoute.of(context)?.settings.arguments
            as Map<String, List<CharacterModel>>;

    List<CharacterModel> characters =
        characterModelsMapArgument[charactersListArgument]!;

    return Row(
      children: [
        Expanded(
          child: CharactersWidget(characters, widget.appConfigHelper, (character) {
            setState(() {
              selectedCharacter = character;
            });
          }),
        ),
        selectedCharacter == null
            ? Expanded(
                child: Container(
                color: Colors.white,
              ))
            : Expanded(child: CharacterDetailsWidget(selectedCharacter)),
      ],
    );
  }
}
