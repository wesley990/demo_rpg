import 'package:flutter/material.dart';

/// AppTheme defines the visual styling for the entire application.
/// It provides a centralized place for managing colors, typography, and component styles.
class AppTheme {
  // Private constructor to prevent instantiation
  const AppTheme._();

  // Color scheme generation
  static ColorScheme _schemeLight(Color seedColor) =>
      ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.light);

  static ColorScheme _schemeDark(Color seedColor) =>
      ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark);

  /// Creates a complete [ThemeData] object based on the provided [ColorScheme].
  /// This method encapsulates all theme-related configurations in one place.
  static ThemeData _createTheme(ColorScheme colorScheme) {
    final containerTheme = _containerTheme(colorScheme);
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: _appBarTheme(colorScheme),
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
      cardTheme: _cardTheme(colorScheme),
      textTheme: _textTheme(colorScheme),
      textButtonTheme: _textButtonTheme(colorScheme),
      elevatedButtonTheme: _elevatedButtonTheme(colorScheme),
      outlinedButtonTheme: _outlinedButtonTheme(colorScheme),
      extensions: [containerTheme],
    );
  }

  /// The light theme for the application.
  static ThemeData lightTheme = _createTheme(_schemeLight(Colors.indigo));

  /// The dark theme for the application.
  static ThemeData darkTheme = _createTheme(_schemeDark(Colors.blue));

  // Component-specific theme methods

  /// Defines the appearance of [AppBar] widgets.
  static AppBarTheme _appBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      elevation: 0,
    );
  }

  /// Defines the appearance of input fields.
  static InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      fillColor: colorScheme.surface,
    );
  }

  /// Defines the appearance of [Card] widgets.
  static CardTheme _cardTheme(ColorScheme colorScheme) {
    return CardTheme(
      color: colorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  /// Defines the text styles for the application.
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

  /// Defines the appearance of [TextButton] widgets.
  static TextButtonThemeData _textButtonTheme(ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  /// Defines the appearance of [ElevatedButton] widgets.
  static ElevatedButtonThemeData _elevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: colorScheme.onPrimary,
        backgroundColor: colorScheme.primary,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  /// Defines the appearance of [OutlinedButton] widgets.
  static OutlinedButtonThemeData _outlinedButtonTheme(ColorScheme colorScheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.primary,
        side: BorderSide(color: colorScheme.primary),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  /// Defines the custom container theme.
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

  // Utility methods for accessing theme properties

  /// Returns the [TextStyle] for large titles.
  static TextStyle titleLarge(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!;

  /// Returns the [TextStyle] for medium body text.
  static TextStyle bodyMedium(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!;

  /// Returns the color for containers.
  static Color colorContainer(BuildContext context) =>
      Theme.of(context).colorScheme.surfaceContainer;

  /// Returns the custom [ContainerThemeData].
  static ContainerThemeData containerTheme(BuildContext context) =>
      Theme.of(context).extension<ContainerThemeData>()!;

  /// Updates both light and dark themes with a new seed color.
  static void updateThemes(Color newSeedColor) {
    lightTheme = _createTheme(_schemeLight(newSeedColor));
    darkTheme = _createTheme(_schemeDark(newSeedColor));
  }
}

/// Custom theme extension for container styling.
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

// Usage examples:

/// How to use the theme in your main.dart file:
///
/// ```dart
/// void main() {
///   runApp(MaterialApp(
///     theme: AppTheme.lightTheme,
///     darkTheme: AppTheme.darkTheme,
///     home: MyHomePage(),
///   ));
/// }
/// ```

/// How to use text styles:
///
/// ```dart
/// Text(
///   'Hello, World!',
///   style: AppTheme.titleLarge(context),
/// )
/// ```

/// How to use container theme:
///
/// ```dart
/// Container(
///   decoration: AppTheme.containerTheme(context).decoration,
///   padding: AppTheme.containerTheme(context).padding,
///   margin: AppTheme.containerTheme(context).margin,
///   child: YourWidget(),
/// )
/// ```

/// How to update seed color:
///
/// ```dart
/// AppTheme.updateThemes(Colors.green);
/// ```