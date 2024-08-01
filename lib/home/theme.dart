import 'package:flutter/material.dart';

/// Abstract base class for theme components.
/// This adheres to the Interface Segregation Principle by providing a simple interface.
abstract class ThemeComponent {
  /// Method to apply this component to a ThemeData object.
  void apply(ThemeData theme);
}

/// Concrete implementation of TextTheme component.
/// Demonstrates Single Responsibility Principle by focusing solely on text theming.
class TextThemeComponent implements ThemeComponent {
  final TextTheme textTheme;

  TextThemeComponent()
      : textTheme = const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
        );

  @override
  void apply(ThemeData theme) {
    theme = theme.copyWith(textTheme: textTheme);
  }
}

/// Concrete implementation of AppBar theme component.
class AppBarThemeComponent implements ThemeComponent {
  @override
  void apply(ThemeData theme) {
    theme = theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        elevation: 0,
      ),
    );
  }
}

/// Concrete implementation of Card theme component.
class CardThemeComponent implements ThemeComponent {
  @override
  void apply(ThemeData theme) {
    theme = theme.copyWith(
      cardTheme: const CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}

/// Concrete implementation of ElevatedButton theme component.
class ElevatedButtonThemeComponent implements ThemeComponent {
  @override
  void apply(ThemeData theme) {
    theme = theme.copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: theme.colorScheme.onPrimary,
          backgroundColor: theme.colorScheme.primary,
        ),
      ),
    );
  }
}

/// Theme builder class responsible for assembling theme components.
/// This class demonstrates the Builder pattern and adheres to the Open/Closed Principle.
/// New theme components can be added without modifying this class.
class ThemeBuilder {
  final Color seedColor;
  final List<ThemeComponent> components;

  ThemeBuilder({required this.seedColor, required this.components});

  /// Builds a ThemeData object based on the provided brightness and components.
  /// This method demonstrates the Dependency Inversion Principle by depending on
  /// abstractions (ThemeComponent) rather than concretions.
  ThemeData buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
    );

    // Apply each component to the theme
    for (var component in components) {
      component.apply(theme);
    }

    return theme;
  }
}

/// AppTheme class for static access to theme data.
/// This class serves as the public API for the theming system.
class AppTheme {
  AppTheme._(); // Private constructor to prevent instantiation

  static late ThemeData lightTheme;
  static late ThemeData darkTheme;
  static late TextTheme textTheme;

  /// Initializes the theme system with the provided seed color.
  /// This method demonstrates the Composition over Inheritance principle
  /// by composing the theme from individual components.
  static void init({required Color seedColor}) {
    final components = [
      TextThemeComponent(),
      AppBarThemeComponent(),
      CardThemeComponent(),
      ElevatedButtonThemeComponent(),
    ];

    final builder = ThemeBuilder(seedColor: seedColor, components: components);

    // Build light and dark themes
    lightTheme = builder.buildTheme(Brightness.light);
    darkTheme = builder.buildTheme(Brightness.dark);

    // Extract text theme for easy access
    textTheme = (components.firstWhere((c) => c is TextThemeComponent)
            as TextThemeComponent)
        .textTheme;
  }
}

/// Usage example:
/// 
/// void main() {
///   AppTheme.init(seedColor: Colors.yellow);
///   runApp(MyApp());
/// }
/// 
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       theme: AppTheme.lightTheme,
///       darkTheme: AppTheme.darkTheme,
///       home: MyHomePage(),
///     );
///   }
/// }
/// 
///  In your widgets:
/// Text('Hello', style: AppTheme.textTheme.titleLarge)