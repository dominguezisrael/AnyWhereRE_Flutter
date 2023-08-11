import 'package:anywherers_code_exercise/app/app_config.dart';
import 'package:anywherers_code_exercise/model/CharacterModel.dart';
import 'package:anywherers_code_exercise/service/CharactersService.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  test('Error message received from service for invalid tv show', () async {
    AppConfig('unknown');

    dynamic response = await CharactersService.requestTvShowCharacters();

    expect(response, throwsA(Exception));
  });

  test('List of characters received from service for valid tv show', () async {
    AppConfig('simpsons characters');

    dynamic response = await CharactersService.requestTvShowCharacters();

    expect(response, isA<List<CharacterModel>>());
  });
}
