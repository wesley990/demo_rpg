import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:demo_rpg/home/theme.dart';

void main() {
  group('AppTheme Unit Tests', () {
    test('lightTheme and darkTheme are created with correct brightness', () {
      expect(AppTheme.lightTheme.brightness, equals(Brightness.light));
      expect(AppTheme.darkTheme.brightness, equals(Brightness.dark));
    });

    test('updateThemes changes both light and dark themes', () {
      final originalLightTheme = AppTheme.lightTheme;
      final originalDarkTheme = AppTheme.darkTheme;

      AppTheme.updateThemes(Colors.green);

      expect(AppTheme.lightTheme, isNot(equals(originalLightTheme)));
      expect(AppTheme.darkTheme, isNot(equals(originalDarkTheme)));
      expect(AppTheme.lightTheme.colorScheme.primary, const Color(0xff3b6939));
      expect(AppTheme.darkTheme.colorScheme.primary, const Color(0xffa1d39a));
    });

    test('AppBarTheme is correctly configured', () {
      final lightAppBarTheme = AppTheme.lightTheme.appBarTheme;
      expect(lightAppBarTheme.backgroundColor,
          equals(AppTheme.lightTheme.colorScheme.primary));
      expect(lightAppBarTheme.foregroundColor,
          equals(AppTheme.lightTheme.colorScheme.onPrimary));
      expect(lightAppBarTheme.elevation, equals(0));
    });

    test('InputDecorationTheme is correctly configured', () {
      final lightInputTheme = AppTheme.lightTheme.inputDecorationTheme;
      expect(lightInputTheme.border, isA<OutlineInputBorder>());
      expect((lightInputTheme.border as OutlineInputBorder).borderRadius,
          equals(BorderRadius.circular(8)));
      expect(lightInputTheme.fillColor,
          equals(AppTheme.lightTheme.colorScheme.surface));
    });

    test('CardTheme is correctly configured', () {
      final lightCardTheme = AppTheme.lightTheme.cardTheme;
      expect(lightCardTheme.color,
          equals(AppTheme.lightTheme.colorScheme.surface));
      expect(lightCardTheme.elevation, equals(2));
      expect(lightCardTheme.shape, isA<RoundedRectangleBorder>());
    });

    test('TextTheme is correctly configured', () {
      final lightTextTheme = AppTheme.lightTheme.textTheme;
      expect(lightTextTheme.titleLarge?.fontSize, equals(40));
      expect(lightTextTheme.titleLarge?.fontWeight, equals(FontWeight.bold));
      expect(lightTextTheme.bodyMedium?.fontSize, equals(50));
    });

    testWidgets('titleLarge returns correct TextStyle',
        (WidgetTester tester) async {
      late TextStyle style;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Builder(
            builder: (BuildContext context) {
              style = AppTheme.titleLarge(context);
              return const Placeholder();
            },
          ),
        ),
      );
      expect(style.fontSize, equals(40));
      expect(style.fontWeight, equals(FontWeight.bold));
      expect(style.color, equals(AppTheme.lightTheme.colorScheme.onPrimary));
    });

    testWidgets('bodyMedium returns correct TextStyle',
        (WidgetTester tester) async {
      late TextStyle style;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Builder(
            builder: (BuildContext context) {
              style = AppTheme.bodyMedium(context);
              return const Placeholder();
            },
          ),
        ),
      );
      expect(style.fontSize, equals(50));
      expect(style.color, equals(AppTheme.lightTheme.colorScheme.onSurface));
    });

    testWidgets('colorContainer returns correct Color',
        (WidgetTester tester) async {
      late Color color;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Builder(
            builder: (BuildContext context) {
              color = AppTheme.colorContainer(context);
              return const Placeholder();
            },
          ),
        ),
      );
      expect(color, equals(AppTheme.lightTheme.colorScheme.surfaceContainer));
    });

    test('updateThemes changes theme data', () {
      final initialLightPrimary = AppTheme.lightTheme.colorScheme.primary;
      final initialDarkPrimary = AppTheme.darkTheme.colorScheme.primary;

      AppTheme.updateThemes(Colors.red);

      expect(AppTheme.lightTheme.colorScheme.primary,
          equals(const Color(0xff904a42)));
      expect(AppTheme.darkTheme.colorScheme.primary,
          equals(const Color(0xffffb4a9)));
      expect(AppTheme.lightTheme.colorScheme.primary,
          isNot(equals(initialLightPrimary)));
      expect(AppTheme.darkTheme.colorScheme.primary,
          isNot(equals(initialDarkPrimary)));
    });

    testWidgets('Widgets can access current theme',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Builder(
            builder: (BuildContext context) {
              final theme = Theme.of(context);
              return Text('Test',
                  style: TextStyle(color: theme.colorScheme.primary));
            },
          ),
        ),
      );

      final Text textWidget = tester.widget(find.text('Test'));
      expect(textWidget.style!.color,
          equals(AppTheme.lightTheme.colorScheme.primary));
    });

    test('Dark theme updates correctly', () {
      final initialDarkPrimary = AppTheme.darkTheme.colorScheme.primary;
      AppTheme.updateThemes(Colors.orange);
      expect(AppTheme.darkTheme.colorScheme.primary,
          equals(const Color(0xfffdb975)));
      expect(AppTheme.darkTheme.colorScheme.primary,
          isNot(equals(initialDarkPrimary)));
    });

    test('Other color scheme properties update correctly', () {
      const newColor = Colors.purple;
      AppTheme.updateThemes(newColor);

      expect(AppTheme.lightTheme.colorScheme.secondary,
          isNot(equals(Colors.indigo)));
      expect(
          AppTheme.darkTheme.colorScheme.secondary, isNot(equals(Colors.blue)));

      expect(AppTheme.lightTheme.colorScheme.surface,
          isNot(equals(Colors.indigo)));
      expect(AppTheme.darkTheme.colorScheme.surface,
          isNot(equals(const Color(0xff006874))));
    });

    // Edge case: Ensure theme works with very light/dark colors
    test('Theme works with extreme colors', () {
      AppTheme.updateThemes(Colors.white);
      expect(AppTheme.lightTheme.colorScheme.primary,
          equals(const Color(0xff006874)));
      expect(AppTheme.darkTheme.colorScheme.primary,
          isNot(equals(const Color(0xff006874))));

      AppTheme.updateThemes(Colors.black);
      expect(AppTheme.darkTheme.colorScheme.primary,
          equals(const Color(0xffffb1c8)));
      expect(AppTheme.lightTheme.colorScheme.primary,
          isNot(equals(const Color(0xffffb1c8))));
    });

    // Edge case: Ensure theme handles color with alpha
    test('Theme handles color with alpha', () {
      final transparentColor = Colors.blue.withOpacity(0.5);
      AppTheme.updateThemes(transparentColor);
      expect(AppTheme.lightTheme.colorScheme.primary,
          equals(const Color(0xff36618e)));
      expect(AppTheme.darkTheme.colorScheme.primary,
          equals(const Color(0xffa0cafd)));
    });
  });
}

class TestWidgetObserver extends NavigatorObserver {
  int updateCount = 0;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    updateCount++;
  }
}
