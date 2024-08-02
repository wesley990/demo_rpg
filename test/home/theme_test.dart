import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:demo_rpg/home/theme.dart'; // Replace with the actual import path

void main() {
  group('AppTheme', () {
    test('lightTheme is created with correct properties', () {
      final theme = AppTheme.lightTheme;
      expect(theme.brightness, equals(Brightness.light));
      expect(theme.colorScheme.primary, isA<Color>());
      expect(theme.useMaterial3, isTrue);
    });

    test('darkTheme is created with correct properties', () {
      final theme = AppTheme.darkTheme;
      expect(theme.brightness, equals(Brightness.dark));
      expect(theme.colorScheme.primary, isA<Color>());
      expect(theme.useMaterial3, isTrue);
    });

    test('updateThemes changes both light and dark themes', () {
      final originalLightPrimary = AppTheme.lightTheme.colorScheme.primary;
      final originalDarkPrimary = AppTheme.darkTheme.colorScheme.primary;

      AppTheme.updateThemes(Colors.green);

      expect(AppTheme.lightTheme.colorScheme.primary,
          isNot(equals(originalLightPrimary)));
      expect(AppTheme.darkTheme.colorScheme.primary,
          isNot(equals(originalDarkPrimary)));
      expect(AppTheme.lightTheme.colorScheme.primary, isA<Color>());
      expect(AppTheme.darkTheme.colorScheme.primary, isA<Color>());
    });

    test('textTheme is correctly configured', () {
      final lightTextTheme = AppTheme.lightTheme.textTheme;
      expect(lightTextTheme.titleLarge?.fontSize, equals(40));
      expect(lightTextTheme.titleMedium?.fontSize, equals(24));
      expect(lightTextTheme.bodyMedium?.fontSize, equals(20));
    });
  });

  group('ContainerThemeData', () {
    test('copyWith creates a new instance with specified properties', () {
      const original = ContainerThemeData(
        color: Colors.red,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(color: Colors.blue),
      );

      final copied = original.copyWith(
        color: Colors.green,
        padding: const EdgeInsets.all(16),
      );

      expect(copied.color, equals(Colors.green));
      expect(copied.padding, equals(const EdgeInsets.all(16)));
      expect(copied.margin, equals(original.margin));
      expect(copied.decoration, equals(original.decoration));
    });

    test('lerp correctly interpolates between two instances', () {
      const a = ContainerThemeData(
        color: Colors.red,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.blue),
      );

      const b = ContainerThemeData(
        color: Colors.green,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.yellow),
      );

      final lerped = a.lerp(b, 0.5);

      expect(lerped.color, equals(Color.lerp(Colors.red, Colors.green, 0.5)));
      expect(lerped.padding, equals(const EdgeInsets.all(15)));
      expect(lerped.margin, equals(const EdgeInsets.all(10)));
      expect(lerped.decoration?.color,
          equals(Color.lerp(Colors.blue, Colors.yellow, 0.5)));
    });
  });

  group('BuildContextThemeExtension', () {
    testWidgets('titleLarge returns correct TextStyle',
        (WidgetTester tester) async {
      late TextStyle capturedStyle;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Builder(
            builder: (BuildContext context) {
              capturedStyle = context.titleLarge;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(capturedStyle.fontSize, equals(40.0));
      expect(capturedStyle.fontWeight, equals(FontWeight.w700));
    });

    testWidgets('bodyMedium returns correct TextStyle',
        (WidgetTester tester) async {
      late TextStyle capturedStyle;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Builder(
            builder: (BuildContext context) {
              capturedStyle = context.bodyMedium;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(capturedStyle.fontSize, equals(20.0));
    });

    testWidgets('titleMedium returns correct TextStyle',
        (WidgetTester tester) async {
      late TextStyle capturedStyle;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Builder(
            builder: (BuildContext context) {
              capturedStyle = context.titleMedium;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(capturedStyle.fontSize, equals(24.0));
      expect(capturedStyle.fontWeight, equals(FontWeight.w700));
    });

    testWidgets('colorContainer returns a Color', (WidgetTester tester) async {
      late Color capturedColor;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Builder(
            builder: (BuildContext context) {
              capturedColor = context.colorContainer;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(capturedColor, isA<Color>());
    });

    testWidgets('BuildContextThemeExtension works with dark theme',
        (WidgetTester tester) async {
      late TextStyle capturedTitleLarge;
      late Color capturedColorContainer;
      late ContainerThemeData capturedContainerTheme;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkTheme,
          home: Builder(
            builder: (BuildContext context) {
              capturedTitleLarge = context.titleLarge;
              capturedColorContainer = context.colorContainer;
              capturedContainerTheme = context.containerTheme;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(capturedTitleLarge.fontSize, equals(40.0));
      expect(capturedTitleLarge.fontWeight, equals(FontWeight.w700));
      expect(capturedColorContainer, isA<Color>());
      expect(capturedContainerTheme, isA<ContainerThemeData>());
    });

    testWidgets('BuildContextThemeExtension handles theme updates',
        (WidgetTester tester) async {
      late Color capturedColorContainer;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Builder(
            builder: (BuildContext context) {
              capturedColorContainer = context.colorContainer;
              return const SizedBox();
            },
          ),
        ),
      );

      // Update the theme
      AppTheme.updateThemes(Colors.purple);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Builder(
            builder: (BuildContext context) {
              capturedColorContainer = context.colorContainer;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(capturedColorContainer, isNot(equals(const Color(0xff515b92))));
      expect(capturedColorContainer, isA<Color>());
    });
  });
}
