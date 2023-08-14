import 'package:anywherers_code_exercise/model/CharacterModel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Character is correctly parsed from Json', () {
    const String expectedCharacterResultValue = 'Character result';
    const String expectedCharacterTextValue = 'Character text';
    const String expectedCharacterIconUrl = 'Character image url';

    CharacterModel characterModel = CharacterModel.fromJson({
      'Result': expectedCharacterResultValue,
      'Text': expectedCharacterTextValue,
      'Icon': {'URL': expectedCharacterIconUrl}
    });

    expect(characterModel.Result, equals(expectedCharacterResultValue));
    expect(characterModel.Text, equals(expectedCharacterTextValue));
    expect(characterModel.Icon.URL, equals(expectedCharacterIconUrl));
  });

  test('Character is correctly parsed to Json', () {
    const String expectedCharacterResultValue = 'Character result';
    const String expectedCharacterTextValue = 'Character text';
    const String expectedCharacterIconUrl = 'Character image url';

    CharacterModel characterModel = CharacterModel(
        Result: expectedCharacterResultValue,
        Text: expectedCharacterTextValue,
        Icon: CharacterIcon(URL: expectedCharacterIconUrl));

    Map<String, dynamic> characterJson = characterModel.toJson();

    expect(characterJson['Result'], equals(expectedCharacterResultValue));
    expect(characterJson['Text'], equals(expectedCharacterTextValue));
    expect(characterJson['Icon'], isA<CharacterIcon>());

    CharacterIcon icon = characterJson['Icon'];

    expect(icon.URL, equals(expectedCharacterIconUrl));
  });

  test('Character icon is correctly parsed to Json', () {
    const String expectedCharacterIconUrl = 'Character image url';

    CharacterIcon icon = CharacterIcon(URL: expectedCharacterIconUrl);

    Map<String, dynamic> iconJson = icon.toJson();

    expect(iconJson['URL'], equals(expectedCharacterIconUrl));
  });

  test('Image url is correctly constructed', () {
    String url = '/testImage.png';

    CharacterModel characterModel =
        CharacterModel(Result: "", Text: "", Icon: CharacterIcon(URL: url));

    expect(characterModel.Icon.getUrl(), equals('https://duckduckgo.com$url'));
  });

  test('Character name is correctly extracted', () {
    String name = 'Bodie Broadus';

    CharacterModel characterModel = CharacterModel(
        Result: "<a href=\"https://duckduckgo.com/Bodie_Broadus\">Bodie Broadus</a><br>Preston \"Bodie\" Broadus is a fictional character on the HBO drama series The Wire, played by actor J. D. Williams. Bodie is initially a rough, low-level drug dealer, but matures throughout the series and slowly rises through the ranks.",
        Text:
            "Bodie Broadus - Preston \"Bodie\" Broadus is a fictional character on the HBO drama series The Wire, played by actor J. D. Williams. Bodie is initially a rough, low-level drug dealer, but matures throughout the series and slowly rises through the ranks.",
        Icon: CharacterIcon(URL: '/i/5675525f.jpg"'));

    expect(characterModel.getName(), equals(name));
  });
}
