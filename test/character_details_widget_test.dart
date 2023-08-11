// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:anywherers_code_exercise/model/CharacterModel.dart';
import 'package:anywherers_code_exercise/view/CharacterDetailsWidget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Character details widget displays correct information',
      (WidgetTester tester) async {
    const expectedText =
        'Alma Gutierrez - Alma M. Gutierrez is a fictional character on the HBO drama The Wire, played by actress Michelle Paress. Gutierrez is a dedicated and idealistic young reporter on the city desk of The Baltimore Sun.';

    CharacterModel characterModel = CharacterModel(
        Result:
            '<a href=\"https://duckduckgo.com/Alma_Gutierrez\">Alma Gutierrez</a><br>Alma M. Gutierrez is a fictional character on the HBO drama The Wire, played by actress Michelle Paress. Gutierrez is a dedicated and idealistic young reporter on the city desk of The Baltimore Sun.',
        Text: expectedText,
        Icon: CharacterIcon(URL: '/i/8690ca01.jpg'));

    await tester.pumpWidget(CharacterDetailsWidget(characterModel));

    expect(find.text('Alma Gutierrez'), findsOneWidget);
    expect(find.text(expectedText), findsOneWidget);
    expect(
        find.image(
            Image.network("https://duckduckgo.com${characterModel.Icon.URL}")
                as ImageProvider<Object>),
        findsOneWidget);
  });
}
