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
    final containerTheme = _containerTheme(colorScheme);
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: _appBarTheme(colorScheme),
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
      cardTheme: _cardTheme(colorScheme),
      textTheme: _textTheme(colorScheme),
      extensions: [containerTheme], // Add container theme as an extension
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

  // Add container theme
  static ContainerThemeData _containerTheme(ColorScheme colorScheme) {
    return ContainerThemeData(
      color: colorScheme.surface,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
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

  // Add method to access container theme
  static ContainerThemeData containerTheme(BuildContext context) =>
      Theme.of(context).extension<ContainerThemeData>()!;

  // Method to update themes with a new seed color
  static void updateThemes(Color newSeedColor) {
    lightTheme = _createTheme(_schemeLight(newSeedColor));
    darkTheme = _createTheme(_schemeDark(newSeedColor));
  }

  // YAGNI: Additional methods can be added here as needed
}

// Define ContainerThemeData
class ContainerThemeData extends ThemeExtension<ContainerThemeData> {
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxDecoration? decoration;

  ContainerThemeData({
    this.color,
    this.padding,
    this.margin,
    this.decoration,
  });

  @override
  ContainerThemeData copyWith({
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxDecoration? decoration,
  }) {
    return ContainerThemeData(
      color: color ?? this.color,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      decoration: decoration ?? this.decoration,
    );
  }

  @override
  ContainerThemeData lerp(ThemeExtension<ContainerThemeData>? other, double t) {
    if (other is! ContainerThemeData) {
      return this;
    }
    return ContainerThemeData(
      color: Color.lerp(color, other.color, t),
      padding: EdgeInsetsGeometry.lerp(padding, other.padding, t),
      margin: EdgeInsetsGeometry.lerp(margin, other.margin, t),
      decoration: BoxDecoration.lerp(decoration, other.decoration, t),
    );
  }
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

// Example of how to use container theme:
// Container(
//   decoration: AppTheme.containerTheme(context).decoration,
//   padding: AppTheme.containerTheme(context).padding,
//   margin: AppTheme.containerTheme(context).margin,
//   child: YourWidget(),
// )

// Example of how to update seed color:
// AppTheme.updateThemes(Colors.green);