import 'package:anywherers_code_exercise/app/app_config.dart';
import 'package:anywherers_code_exercise/assets/constants.dart';
import 'package:flutter/material.dart';

import '../model/CharacterModel.dart';

typedef ItemSelectedCallback = void Function(CharacterModel selectedCharacter);

class CharactersWidget extends StatefulWidget {
  final List<CharacterModel> charactersModel;
  final ItemSelectedCallback? onItemSelected;

  const CharactersWidget(this.charactersModel, this.onItemSelected,
      {super.key});

  @override
  State<CharactersWidget> createState() => _CharactersWidgetState();
}

class _CharactersWidgetState extends State<CharactersWidget> {
  List<CharacterModel> characters = [];
  List<CharacterModel> filteredCharacters = [];
  bool searchActive = false;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (characters.isEmpty) {
      if (widget.charactersModel.isEmpty) {
        Map<String, List<CharacterModel>> characterModelsMapArgument =
            ModalRoute.of(context)?.settings.arguments
                as Map<String, List<CharacterModel>>;

        characters = characterModelsMapArgument[charactersListArgument]!;
      } else {
        characters = widget.charactersModel;
      }
    }

    if (filteredCharacters.isEmpty) {
      filteredCharacters = characters;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Characters"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: getSearchIcon(),
          ),
        ],
      ),
      body: getBody(),
    );
  }

  Widget getSearchIcon() {
    if (searchActive) {
      return GestureDetector(
        onTap: () {
          setState(() {
            searchActive = false;

            filteredCharacters = characters;
          });
        },
        child: const Icon(
          Icons.search_off,
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            searchActive = true;

            textEditingController = TextEditingController();
          });
        },
        child: const Icon(
          Icons.search,
        ),
      );
    }
  }

  Widget getBody() {
    if (searchActive) {
      return Column(
        children: [
          const SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (filter) {
                filterCharacters(filter);
              },
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: "Search character...",
                hintText: "Search character",
                prefixIcon: const Icon(
                  Icons.search,
                ),
                enabledBorder: getInputBorder(),
                focusedBorder: getInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: getListView(),
          )
        ],
      );
    } else {
      return getListView();
    }
  }

  InputBorder getInputBorder() {
    Color? borderColorTemp = AppConfig.tvShow == TvShow.simpsons
        ? Colors.yellow[400]
        : Colors.grey[400];

    final Color color = borderColorTemp ?? Colors.black;

    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(20.0),
      ),
    );
  }

  Widget getListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: filteredCharacters.length,
      itemBuilder: (context, index) {
        CharacterModel characterModel = filteredCharacters[index];

        return getCharacterWidget(characterModel);
      },
    );
  }

  Widget getCharacterWidget(CharacterModel characterModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      child: Card(
        elevation: 4.0,
        child: ListTile(
          title: Text(
            characterModel.getName(),
          ),
          onTap: () {
            if (AppConfig.isTablet()) {
              widget.onItemSelected!(characterModel);
            } else {
              displayCharacterDetails(characterModel);
            }
          },
        ),
      ),
    );
  }

  void filterCharacters(String filter) {
    List<CharacterModel> filterResults = characters
        .where((character) =>
            character.Text.toLowerCase().contains(filter.toLowerCase()) ||
            character.Result.toLowerCase().contains(filter.toLowerCase()))
        .toList();

    setState(() {
      filteredCharacters = filterResults;
    });
  }

  void displayCharacterDetails(CharacterModel characterModel) {
    if (!context.mounted) return;

    Navigator.of(context).pushNamed(Routes.characterDetail.name,
        arguments: {characterArgument: characterModel});
  }
}
