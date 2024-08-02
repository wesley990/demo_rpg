import 'package:flutter/material.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  const AppTheme._();

  // KISS: Keep the color scheme generation simple
  static ColorScheme _schemeLight(Color seedColor) {
    return ColorScheme.fromSeed(
        seedColor: seedColor, brightness: Brightness.light);
  }

  static ColorScheme _schemeDark(Color seedColor) {
    return ColorScheme.fromSeed(
        seedColor: seedColor, brightness: Brightness.dark);
  }

  // Encapsulate Changes: This method allows easy modification of the entire theme
  static ThemeData _createTheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: _appBarTheme(colorScheme),
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
      cardTheme: _cardTheme(colorScheme),
      textTheme: _textTheme(colorScheme),
    );
  }

  // DRY: Reuse the color scheme generation
  static ThemeData lightTheme = _createTheme(_schemeLight(Colors.indigo));
  static ThemeData darkTheme = _createTheme(_schemeDark(Colors.blue));

  // Separation of Concerns: Each component has its own theme method
  static AppBarTheme _appBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      elevation: 0,
    );
  }

  static InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      fillColor: colorScheme.surface,
    );
  }

  static CardTheme _cardTheme(ColorScheme colorScheme) {
    return CardTheme(
      color: colorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  static TextTheme _textTheme(ColorScheme colorScheme) {
    return TextTheme(
      titleLarge: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        color: colorScheme.onPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 50,
        color: colorScheme.onSurface,
      ),
    );
  }

  // Open/Closed Principle: Easy to extend with new text styles
  // These methods now use the current theme instead of being tied to lightTheme
  static TextStyle titleLarge(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!;
  static TextStyle bodyMedium(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!;
  static Color colorContainer(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainer;

  // Method to update themes with a new seed color
  static void updateThemes(Color newSeedColor) {
    lightTheme = _createTheme(_schemeLight(newSeedColor));
    darkTheme = _createTheme(_schemeDark(newSeedColor));
  }

  // YAGNI: Additional methods can be added here as needed
}

// Example of how to use the theme:
// void main() {
//   runApp(MaterialApp(
//     theme: AppTheme.lightTheme,
//     darkTheme: AppTheme.darkTheme,
//     home: MyHomePage(),
//   ));
// }

// Example of how to use text styles:
// Text(
//   'Hello, World!',
//   style: AppTheme.titleLarge(context),
// )

// Example of how to update seed color:
// AppTheme.updateThemes(Colors.green);