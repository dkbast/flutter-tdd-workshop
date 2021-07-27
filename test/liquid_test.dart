import 'package:flutter/rendering.dart';
import 'package:liquid_simulation/hazardous_liquid.dart';
import 'package:liquid_simulation/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_simulation/temperature_model.dart';

final Finder liquidFinder = find.descendant(
    of: find.byType(HazardousLiquid), matching: find.byType(Container));

void main() {
  testWidgets('Starts with 19.0°C', (tester) async {
    await tester.pumpWidget(LabApp());
    expect(find.text('19.0°C'), findsOneWidget);
  });

  group('test colors', () {
    final testMap = {
      -1: 0xff1f3dff,
      9: 0xff1f88ff,
      17: 0xff20bbe6,
      25: 0xff24ebf2,
      39: 0xff1ddb99,
      50: 0xff1ec943,
      58: 0xff5da82a,
      73: 0xffc2c240,
      83: 0xffffac26,
      85: 0xffff4400,
    };
    for (final entrySet in testMap.entries) {
      testWidgets('$entrySet.key°C is ${entrySet.value}', (tester) async {
        await testTemperature(
            entrySet.key.toDouble(), Color(entrySet.value), tester);
      });
    }
  });

  testWidgets('tap increment increases temperature by 5', (tester) async {
    await tester.pumpWidget(LabApp());
    final incrementFinder = find.text('+5');

    expect(incrementFinder, findsOneWidget);
    await tester.tap(incrementFinder);

    await tester.pumpAndSettle(const Duration(seconds: 5));

    final tempTextFinder = find.byKey(const ValueKey('temperatureText'));
    expect(tempTextFinder, findsOneWidget);
    final tempText = tester.widget<Text>(tempTextFinder);
    expect(tempText.data, '24.0°C');
  });

  testWidgets('tap decrement decreases temperature by 5', (tester) async {
    await tester.pumpWidget(LabApp());

    final decrementFinder = find.text('-5');
    expect(decrementFinder, findsOneWidget);

    await tester.tap(decrementFinder);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    final tempTextFinder = find.byKey(const ValueKey('temperatureText'));
    expect(tempTextFinder, findsOneWidget);
    final tempText = tester.widget<Text>(tempTextFinder);
    expect(tempText.data, '14.0°C');
  });
}

Future<void> testTemperature(
    double temperature, Color color, WidgetTester tester) async {
  await tester.pumpWidget(LabApp());
  expect(find.byType(TextField), findsOneWidget);
  await tester.enterText(
      find.byType(TextField), temperature.toInt().toString());

  await tester.tap(find.text('Confirm'));
  await tester.pumpAndSettle(const Duration(seconds: 5));
  final containerFinder =
      find.byKey(const ValueKey('hazardousLiquidContainer'));

  expect(containerFinder, findsOneWidget);

  final container = tester.widget<Container>(containerFinder);

  expect(container.color, color);
}
