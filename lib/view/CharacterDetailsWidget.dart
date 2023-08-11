import 'package:anywherers_code_exercise/assets/constants.dart';
import 'package:anywherers_code_exercise/model/CharacterModel.dart';
import 'package:flutter/material.dart';

class CharacterDetailsWidget extends StatefulWidget {
  final CharacterModel? characterModel;

  const CharacterDetailsWidget(this.characterModel, {super.key});

  @override
  State<CharacterDetailsWidget> createState() => _CharacterDetailsWidgetState();
}

class _CharacterDetailsWidgetState extends State<CharacterDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    CharacterModel character;

    if (widget.characterModel != null) {
      character = widget.characterModel!;
    } else {
      Map<String, CharacterModel> characterModelArgument =
          ModalRoute.of(context)?.settings.arguments
              as Map<String, CharacterModel>;

      character = characterModelArgument[characterArgument]!;
    }

    List<String> descriptionParts = character.Text.split(" - ");
    String characterName = descriptionParts[0];
    String characterDescription = descriptionParts[1];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Character details"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: character.getName(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontSize: 18.0,
                      letterSpacing: 2.0,
                      color: Colors.grey[850],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                getImageForCharacter(character),
                const SizedBox(
                  height: 30.0,
                ),
                RichText(
                  text: TextSpan(
                    text: characterName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 16.0,
                      letterSpacing: 2.0,
                      color: Colors.grey[800],
                    ),
                    children: [
                      TextSpan(
                        text: ' - $characterDescription',
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          fontSize: 16.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getImageForCharacter(CharacterModel character) {
    return character.Icon.URL.isEmpty
        ? Image.asset("assets/no_available_image_for_character_image.jpg")
        : Image.network(character.Icon.getUrl());
  }
}
