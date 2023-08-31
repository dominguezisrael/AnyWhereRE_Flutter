import 'package:anywherers_code_exercise/app/app_config.dart';
import 'package:anywherers_code_exercise/assets/constants.dart';
import 'package:anywherers_code_exercise/model/CharacterModel.dart';
import 'package:anywherers_code_exercise/view/CharacterDetailsWidget.dart';
import 'package:anywherers_code_exercise/view/CharactersWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class NavigatorObserverMock extends Mock implements NavigatorObserver {}

class AppConfigHelperMock extends Mock implements AppConfigHelper {}

class RouteFake extends Fake implements Route {}

void main() {
  List<CharacterModel> characterList = [];

  setUpAll(() {
    CharacterModel character1 = CharacterModel(
        Result:
            '<a href=\"https://duckduckgo.com/Alma_Gutierrez\">Alma Gutierrez</a><br>Alma M. Gutierrez is a fictional character on the HBO drama The Wire, played by actress Michelle Paress. Gutierrez is a dedicated and idealistic young reporter on the city desk of The Baltimore Sun.',
        Text:
            "Alma Gutierrez - Alma M. Gutierrez is a fictional character on the HBO drama The Wire, played by actress Michelle Paress. Gutierrez is a dedicated and idealistic young reporter on the city desk of The Baltimore Sun.",
        Icon: CharacterIcon(URL: '/i/8690ca01.jpg'));

    CharacterModel character2 = CharacterModel(
        Result:
            '<a href=\"https://duckduckgo.com/Brother_Mouzone\">Brother Mouzone</a><br>Brother Mouzone is a fictional character on the HBO drama The Wire, played by actor Michael Potts.',
        Text:
            "Brother Mouzone - Brother Mouzone is a fictional character on the HBO drama The Wire, played by actor Michael Potts.",
        Icon: CharacterIcon(URL: ''));

    characterList = [character1, character2];
  });

  group("UI interactions test", () {
    const expectedCharacter1Name = 'Alma Gutierrez';
    const expectedCharacter2Name = 'Brother Mouzone';

    testWidgets('A ListView widget is shown for the list of characters',
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: Material(
          child: CharactersWidget(characterList, AppConfigHelper()),
        ),
      ));

      expect(
          widgetTester
              .widget(find.byKey(CharactersWidget.characterListWidgetKey)),
          isA<ListView>());
    });

    testWidgets('A character container widget is shown for each character',
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: Material(
          child: CharactersWidget(characterList, AppConfigHelper()),
        ),
      ));

      expect(
          widgetTester
              .widgetList(find.byKey(CharactersWidget.characterContainer))
              .length,
          2);
    });

    testWidgets("A Text widget is shown with character's names",
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: Material(
          child: CharactersWidget(characterList, AppConfigHelper()),
        ),
      ));

      expect(find.text(expectedCharacter1Name), findsOneWidget);
      expect(find.text(expectedCharacter2Name), findsOneWidget);
    });

    testWidgets(
        "No Image widget found to guarantee only displaying character's name",
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: Material(
          child: CharactersWidget(characterList, AppConfigHelper()),
        ),
      ));

      expect(find.byType(Image).evaluate(), isEmpty);
    });

    testWidgets('Search icon is present', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: Material(
          child: CharactersWidget(characterList, AppConfigHelper()),
        ),
      ));

      Widget searchIconWidget =
          widgetTester.widget(find.byKey(CharactersWidget.searchIconKey));
      Finder widgetsFound =
          find.widgetWithIcon(searchIconWidget.runtimeType, Icons.search);

      expect(widgetsFound, findsOneWidget);
    });

    testWidgets('Search off icon is shown after taping on search icon',
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: Material(
          child: CharactersWidget(characterList, AppConfigHelper()),
        ),
      ));

      await widgetTester.tap(find.byKey(CharactersWidget.searchIconKey));
      await widgetTester.pump();

      expect(find.byKey(CharactersWidget.searchOffIconKey), findsOneWidget);
    });

    testWidgets('Search box is shown after taping on search icon',
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: Material(
          child: CharactersWidget(characterList, AppConfigHelper()),
        ),
      ));

      await widgetTester.tap(find.byKey(CharactersWidget.searchIconKey));
      await widgetTester.pump();

      expect(find.byKey(CharactersWidget.searchBoxWidgetKey), findsOneWidget);
    });

    testWidgets('Filter list of characters with valid criteria',
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: Material(
          child: CharactersWidget(characterList, AppConfigHelper()),
        ),
      ));

      await widgetTester.tap(find.byKey(CharactersWidget.searchIconKey));
      await widgetTester.pump();

      await widgetTester.enterText(
          find.byType(TextField), expectedCharacter1Name);
      await widgetTester.pump();

      Finder characterContainerFinder =
          find.byKey(CharactersWidget.characterContainer);

      expect(characterContainerFinder, findsOneWidget);

      Widget characterContainerWidget =
          widgetTester.widget(characterContainerFinder);
      Finder widgetsFound = find.widgetWithText(
          characterContainerWidget.runtimeType, expectedCharacter1Name);
      expect(widgetsFound, findsOneWidget);
    });

    testWidgets('Filter list of characters with invalid criteria',
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: Material(
          child: CharactersWidget(characterList, AppConfigHelper()),
        ),
      ));

      await widgetTester.tap(find.byKey(CharactersWidget.searchIconKey));
      await widgetTester.pump();

      await widgetTester.enterText(
          find.byType(TextField), "invalid filter criteria");
      await widgetTester.pump();

      Finder emptyViewFinder = find.byKey(CharactersWidget.emptyViewWidgetKey);

      expect(emptyViewFinder, findsOneWidget);
    });

    testWidgets('Search icon is shown after tapping search off icon',
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: Material(
          child: CharactersWidget(characterList, AppConfigHelper()),
        ),
      ));

      Finder searchIconWidgetFinder =
          find.byKey(CharactersWidget.searchIconKey);

      await widgetTester.tap(searchIconWidgetFinder);
      await widgetTester.pump();

      await widgetTester.tap(find.byKey(CharactersWidget.searchOffIconKey));
      await widgetTester.pump();

      expect(searchIconWidgetFinder, findsOneWidget);
    });

    testWidgets('Search box is hidden after tapping cancel search icon',
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: Material(
          child: CharactersWidget(characterList, AppConfigHelper()),
        ),
      ));

      await widgetTester.tap(find.byKey(CharactersWidget.searchIconKey));
      await widgetTester.pump();

      await widgetTester.tap(find.byKey(CharactersWidget.searchOffIconKey));
      await widgetTester.pump();

      expect(
          find.byKey(CharactersWidget.searchBoxWidgetKey).evaluate(), isEmpty);
    });
  });

  group("Navigation tests", () {
    late NavigatorObserver navigatorObserverMock;
    late AppConfigHelper appConfigHelperMock;

    setUp(() {
      navigatorObserverMock = NavigatorObserverMock();
      appConfigHelperMock = AppConfigHelperMock();

      registerFallbackValue(RouteFake());
    });

    testWidgets(
        'Navigate from characters list to character details after tapping a character',
        (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: Material(
          child: CharactersWidget(characterList, appConfigHelperMock),
        ),
        navigatorObservers: [navigatorObserverMock],
        routes: {
          Routes.characterDetail.name: (context) =>
              const CharacterDetailsWidget(),
        },
      ));

      when(() => appConfigHelperMock.isTablet()).thenReturn(false);

      await widgetTester
          .tap(find.byKey(CharactersWidget.characterNameContainer).first);
      await widgetTester.pumpAndSettle();

      verify(() => navigatorObserverMock.didPush(any<Route>(), null));

      expect(find.byType(CharactersWidget), findsNothing);
      expect(find.byType(CharacterDetailsWidget), findsOneWidget);
    });
  });
}
