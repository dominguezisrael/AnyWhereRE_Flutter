enum Routes {
  home(name: '/'),
  characters(name: 'characters'),
  characterDetail(name: 'character_detail'),
  charactersAndDetail(name: 'characters_and_detail');

  const Routes({required this.name});

  final String name;
}

const String charactersListArgument = "CHARACTERS_LIST_ARGUMENT";
const String characterArgument = "CHARACTER_ARGUMENT";
