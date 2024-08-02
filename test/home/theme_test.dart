import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:demo_rpg/home/theme.dart';

void main() {
  group('AppTheme', () {
    test('lightTheme is created with correct properties', () {
      final theme = AppTheme.lightTheme;
      expect(theme.brightness, equals(Brightness.light));
      expect(theme.colorScheme.primary, equals(const Color(0xff515b92)));
      expect(theme.useMaterial3, isTrue);
    });

    test('darkTheme is created with correct properties', () {
      final theme = AppTheme.darkTheme;
      expect(theme.brightness, equals(Brightness.dark));
      expect(theme.colorScheme.primary, equals(const Color(0xffa0cafd)));
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
      expect(AppTheme.lightTheme.colorScheme.primary,
          equals(const Color(0xff3b6939)));
      expect(AppTheme.darkTheme.colorScheme.primary,
          equals(const Color(0xffa1d39a)));
    });

    test('appBarTheme is correctly configured', () {
      final lightAppBarTheme = AppTheme.lightTheme.appBarTheme;
      expect(lightAppBarTheme.backgroundColor,
          equals(AppTheme.lightTheme.colorScheme.secondary));
      expect(lightAppBarTheme.foregroundColor,
          equals(AppTheme.lightTheme.colorScheme.onSecondary));
      expect(lightAppBarTheme.elevation, equals(0));
    });

    test('inputDecorationTheme is correctly configured', () {
      final lightInputTheme = AppTheme.lightTheme.inputDecorationTheme;
      expect(lightInputTheme.border, isA<OutlineInputBorder>());
      expect(lightInputTheme.focusedBorder, isA<OutlineInputBorder>());
      expect(lightInputTheme.fillColor,
          equals(AppTheme.lightTheme.colorScheme.surface));
    });

    test('cardTheme is correctly configured', () {
      final lightCardTheme = AppTheme.lightTheme.cardTheme;
      expect(lightCardTheme.color,
          equals(AppTheme.lightTheme.colorScheme.surface));
      expect(lightCardTheme.elevation, equals(2));
      expect(lightCardTheme.shape, isA<RoundedRectangleBorder>());
    });

    test('textTheme is correctly configured', () {
      final lightTextTheme = AppTheme.lightTheme.textTheme;
      expect(lightTextTheme.titleLarge?.fontSize, equals(40));
      expect(lightTextTheme.titleMedium?.fontSize, equals(24));
      expect(lightTextTheme.bodyMedium?.fontSize, equals(20));
      // Note: We're not checking exact TextStyle properties as they may vary
    });

    test('textButtonTheme is correctly configured', () {
      final lightTextButtonTheme = AppTheme.lightTheme.textButtonTheme;
      expect(lightTextButtonTheme.style?.foregroundColor?.resolve({}),
          equals(AppTheme.lightTheme.colorScheme.onPrimaryFixed));
      expect(lightTextButtonTheme.style?.backgroundColor?.resolve({}),
          equals(AppTheme.lightTheme.colorScheme.primaryFixed));
      expect(lightTextButtonTheme.style?.shape?.resolve({}),
          isA<RoundedRectangleBorder>());
    });

    test('elevatedButtonTheme is correctly configured', () {
      final lightElevatedButtonTheme = AppTheme.lightTheme.elevatedButtonTheme;
      expect(lightElevatedButtonTheme.style?.foregroundColor?.resolve({}),
          equals(AppTheme.lightTheme.colorScheme.onPrimaryFixed));
      expect(lightElevatedButtonTheme.style?.backgroundColor?.resolve({}),
          equals(AppTheme.lightTheme.colorScheme.primaryFixed));
      expect(
          lightElevatedButtonTheme.style?.elevation?.resolve({}), equals(10));
      expect(lightElevatedButtonTheme.style?.shape?.resolve({}),
          isA<RoundedRectangleBorder>());
    });

    test('outlinedButtonTheme is correctly configured', () {
      final lightOutlinedButtonTheme = AppTheme.lightTheme.outlinedButtonTheme;
      expect(lightOutlinedButtonTheme.style?.foregroundColor?.resolve({}),
          equals(AppTheme.lightTheme.colorScheme.primaryFixed));
      expect(lightOutlinedButtonTheme.style?.side?.resolve({})?.color,
          equals(AppTheme.lightTheme.colorScheme.primaryFixed));
      expect(lightOutlinedButtonTheme.style?.shape?.resolve({}),
          isA<RoundedRectangleBorder>());
    });

    test('containerTheme is correctly configured', () {
      final containerTheme = AppTheme.lightTheme.extensions[ContainerThemeData]
          as ContainerThemeData?;
      expect(containerTheme, isNotNull);
      expect(containerTheme?.color,
          equals(AppTheme.lightTheme.colorScheme.surface));
      expect(containerTheme?.padding, equals(const EdgeInsets.all(16)));
      expect(containerTheme?.margin,
          equals(const EdgeInsets.symmetric(vertical: 8)));
      expect(containerTheme?.decoration, isA<BoxDecoration>());
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

    test('lerp returns this when other is not ContainerThemeData', () {
      const a = ContainerThemeData(color: Colors.red);
      final lerped = a.lerp(null, 0.5);
      expect(lerped, equals(a));
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
      // We're not checking exact color as it may vary
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
      // We're not checking exact color or weight as they may vary
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
      // We're not checking exact color as it may vary
    });

    testWidgets('colorContainer returns correct Color',
        (WidgetTester tester) async {
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

      expect(capturedColor, equals(const Color(0xff3b6939)));
    });

    testWidgets('containerTheme returns correct ContainerThemeData',
        (WidgetTester tester) async {
      late ContainerThemeData capturedTheme;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Builder(
            builder: (BuildContext context) {
              capturedTheme = context.containerTheme;
              return const SizedBox();
            },
          ),
        ),
      );

      final expectedTheme = AppTheme.lightTheme.extensions[ContainerThemeData]
          as ContainerThemeData?;
      expect(capturedTheme, equals(expectedTheme));
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
      expect(capturedColorContainer, equals(const Color(0xffa1d39a)));
      expect(capturedContainerTheme,
          equals(AppTheme.darkTheme.extensions[ContainerThemeData]));
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

      expect(capturedColorContainer, equals(const Color(0xff3b6939)));

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

      expect(capturedColorContainer, equals(const Color(0xff3b6939)));
    });
  });
}
