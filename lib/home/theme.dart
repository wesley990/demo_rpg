import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// AppTheme class defines the application's theme, including light and dark modes.
/// It provides a centralized place to manage colors, text styles, and component themes.
class AppTheme {
  AppTheme._(); // Private constructor to prevent instantiation

  // Define seed colors for light and dark themes
  static const Color _lightSeedColor = Colors.blue;
  static const Color _darkSeedColor = Colors.blue;

  /// Light theme configuration
  static final ThemeData lightTheme =
      _getThemeData(_lightSeedColor, Brightness.light);

  /// Dark theme configuration
  static final ThemeData darkTheme =
      _getThemeData(_darkSeedColor, Brightness.dark);

  /// Helper method to generate ThemeData based on seed color and brightness
  static ThemeData _getThemeData(Color seedColor, Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: brightness,
    ).copyWith(
      // Apply custom theme data for various components
      badgeTheme: _badgeTheme(colorScheme),
      bottomAppBarTheme: _bottomAppBarTheme(colorScheme),
      bottomSheetTheme: _bottomSheetTheme(colorScheme),
      elevatedButtonTheme: _elevatedButtonTheme(colorScheme),
      filledButtonTheme: _filledButtonTheme(colorScheme),
      outlinedButtonTheme: _outlinedButtonTheme(colorScheme),
      textButtonTheme: _textButtonTheme(colorScheme),
      floatingActionButtonTheme: _floatingActionButtonTheme(colorScheme),
      iconButtonTheme: _iconButtonTheme(colorScheme),
      cardTheme: _cardTheme(colorScheme),
      checkboxTheme: _checkboxTheme(colorScheme),
      chipTheme: _chipTheme(colorScheme),
      dialogTheme: _dialogTheme(colorScheme),
      dividerTheme: _dividerTheme(colorScheme),
      listTileTheme: _listTileTheme(colorScheme),
      navigationBarTheme: _navigationBarTheme(colorScheme),
      navigationDrawerTheme: _navigationDrawerTheme(colorScheme),
      navigationRailTheme: _navigationRailTheme(colorScheme),
      progressIndicatorTheme: _progressIndicatorTheme(colorScheme),
      radioTheme: _radioTheme(colorScheme),
      sliderTheme: _sliderTheme(colorScheme),
      switchTheme: _switchTheme(colorScheme),
      tabBarTheme: _tabBarTheme(colorScheme),
      textSelectionTheme: _textSelectionTheme(colorScheme),
      timePickerTheme: _timePickerTheme(colorScheme),
      appBarTheme: _appBarTheme(colorScheme),
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
      extensions: [
        containerTheme(colorScheme),
      ],
    );
  }

  /// Predefined Container Theme
  static ContainerTheme containerTheme(ColorScheme colorScheme) =>
      ContainerTheme(
        defaultPadding: const EdgeInsets.all(8.0),
        defaultMargin: const EdgeInsets.all(0.0),
        defaultBorderRadius: BorderRadius.circular(15.0),
        defaultColor: colorScheme.primaryContainer,
      );

  // Text styles
  static const TextStyle displayLarge =
      TextStyle(fontSize: 57, fontWeight: FontWeight.normal);
  static const TextStyle displayMedium =
      TextStyle(fontSize: 45, fontWeight: FontWeight.normal);
  static const TextStyle displaySmall =
      TextStyle(fontSize: 36, fontWeight: FontWeight.normal);
  static const TextStyle headlineLarge =
      TextStyle(fontSize: 32, fontWeight: FontWeight.normal);
  static const TextStyle headlineMedium =
      TextStyle(fontSize: 28, fontWeight: FontWeight.normal);
  static const TextStyle headlineSmall =
      TextStyle(fontSize: 24, fontWeight: FontWeight.normal);
  static const TextStyle titleLarge =
      TextStyle(fontSize: 22, fontWeight: FontWeight.normal);
  static const TextStyle titleMedium =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static const TextStyle titleSmall =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  static const TextStyle bodyLarge =
      TextStyle(fontSize: 16, fontWeight: FontWeight.normal);
  static const TextStyle bodyMedium =
      TextStyle(fontSize: 14, fontWeight: FontWeight.normal);
  static const TextStyle bodySmall =
      TextStyle(fontSize: 12, fontWeight: FontWeight.normal);
  static const TextStyle labelLarge =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  static const TextStyle labelMedium =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  static const TextStyle labelSmall =
      TextStyle(fontSize: 11, fontWeight: FontWeight.w500);

  // Component InputDecorationTheme
  static InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: colorScheme.onSurface,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: colorScheme.primary,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(
          color: colorScheme.onSurface.withOpacity(0.5),
        ),
      ),
      labelStyle: TextStyle(
        color: colorScheme.onSurface,
      ),
      hintStyle: TextStyle(
        color: colorScheme.onSurface.withOpacity(0.5),
      ),
    );
  }

  // Updated theme methods
  static BadgeThemeData _badgeTheme(ColorScheme colorScheme) => BadgeThemeData(
        backgroundColor: colorScheme.secondary,
        textColor: colorScheme.onSecondary,
      );

  static BottomAppBarTheme _bottomAppBarTheme(ColorScheme colorScheme) =>
      BottomAppBarTheme(
        color: colorScheme.surface,
        elevation: 0,
      );

  static BottomSheetThemeData _bottomSheetTheme(ColorScheme colorScheme) =>
      BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        modalBackgroundColor: colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      );

  static ElevatedButtonThemeData _elevatedButtonTheme(
          ColorScheme colorScheme) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
        ),
      );

  static FilledButtonThemeData _filledButtonTheme(ColorScheme colorScheme) =>
      FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
        ),
      );

  static OutlinedButtonThemeData _outlinedButtonTheme(
          ColorScheme colorScheme) =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          side: BorderSide(color: colorScheme.outline),
        ),
      );

  static TextButtonThemeData _textButtonTheme(ColorScheme colorScheme) =>
      TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
        ),
      );

  static FloatingActionButtonThemeData _floatingActionButtonTheme(
          ColorScheme colorScheme) =>
      FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      );

  static IconButtonThemeData _iconButtonTheme(ColorScheme colorScheme) =>
      IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: colorScheme.primary,
        ),
      );

  static CardTheme _cardTheme(ColorScheme colorScheme) => CardTheme(
        color: colorScheme.surface,
        shadowColor: colorScheme.shadow,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      );

  static CheckboxThemeData _checkboxTheme(ColorScheme colorScheme) =>
      CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.surface;
        }),
        checkColor: WidgetStateProperty.all(colorScheme.onPrimary),
      );

  static ChipThemeData _chipTheme(ColorScheme colorScheme) => ChipThemeData(
        backgroundColor: colorScheme.surface,
        deleteIconColor: colorScheme.onSurface,
        labelStyle: TextStyle(color: colorScheme.onSurface),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      );

  static DialogTheme _dialogTheme(ColorScheme colorScheme) => DialogTheme(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      );

  static DividerThemeData _dividerTheme(ColorScheme colorScheme) =>
      DividerThemeData(
        color: colorScheme.outline,
        thickness: 1,
      );

  static ListTileThemeData _listTileTheme(ColorScheme colorScheme) =>
      ListTileThemeData(
        tileColor: colorScheme.surface,
        iconColor: colorScheme.primary,
        textColor: colorScheme.onSurface,
      );

  static NavigationBarThemeData _navigationBarTheme(ColorScheme colorScheme) =>
      NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primaryContainer,
        labelTextStyle:
            WidgetStateProperty.all(TextStyle(color: colorScheme.onSurface)),
      );

  static NavigationDrawerThemeData _navigationDrawerTheme(
          ColorScheme colorScheme) =>
      NavigationDrawerThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primaryContainer,
      );

  static NavigationRailThemeData _navigationRailTheme(
          ColorScheme colorScheme) =>
      NavigationRailThemeData(
        backgroundColor: colorScheme.surface,
        selectedIconTheme: IconThemeData(color: colorScheme.primary),
        unselectedIconTheme: IconThemeData(color: colorScheme.onSurface),
      );

  static ProgressIndicatorThemeData _progressIndicatorTheme(
          ColorScheme colorScheme) =>
      ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: colorScheme.primaryContainer,
      );

  static RadioThemeData _radioTheme(ColorScheme colorScheme) => RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.onSurface;
        }),
      );

  static SliderThemeData _sliderTheme(ColorScheme colorScheme) =>
      SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.primaryContainer,
        thumbColor: colorScheme.primary,
        overlayColor: colorScheme.primary.withOpacity(0.12),
      );

  static SwitchThemeData _switchTheme(ColorScheme colorScheme) =>
      SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primaryContainer;
          }
          return colorScheme.surfaceContainerHighest;
        }),
      );

  static TabBarTheme _tabBarTheme(ColorScheme colorScheme) => TabBarTheme(
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.onSurface,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      );

  static TextSelectionThemeData _textSelectionTheme(ColorScheme colorScheme) =>
      TextSelectionThemeData(
        cursorColor: colorScheme.primary,
        selectionColor: colorScheme.primary.withOpacity(0.2),
        selectionHandleColor: colorScheme.primary,
      );

  static TimePickerThemeData _timePickerTheme(ColorScheme colorScheme) =>
      TimePickerThemeData(
        backgroundColor: colorScheme.surface,
        hourMinuteColor: colorScheme.primaryContainer,
        hourMinuteTextColor: colorScheme.onPrimaryContainer,
        dialHandColor: colorScheme.primary,
        dialBackgroundColor: colorScheme.primaryContainer,
      );

  static AppBarTheme _appBarTheme(ColorScheme colorScheme) => AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        // toolbarHeight: 40,
        titleTextStyle: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimary,
        ),
        iconTheme: IconThemeData(
          color: colorScheme.onPrimary,
        ),
        actionsIconTheme: IconThemeData(
          color: colorScheme.onPrimary,
        ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: colorScheme.primary,
          statusBarIconBrightness: Brightness.light,
        ),
      );
}

/// ContainerTheme extends ThemeExtension to provide custom container styling
class ContainerTheme extends ThemeExtension<ContainerTheme> {
  final EdgeInsetsGeometry defaultPadding;
  final EdgeInsetsGeometry defaultMargin;
  final BorderRadius defaultBorderRadius;
  final Color defaultColor;

  ContainerTheme({
    required this.defaultPadding,
    required this.defaultMargin,
    required this.defaultBorderRadius,
    required this.defaultColor,
  });

  @override
  ThemeExtension<ContainerTheme> copyWith({
    EdgeInsetsGeometry? defaultPadding,
    EdgeInsetsGeometry? defaultMargin,
    BorderRadius? defaultBorderRadius,
    Color? defaultColor,
  }) {
    return ContainerTheme(
      defaultPadding: defaultPadding ?? this.defaultPadding,
      defaultMargin: defaultMargin ?? this.defaultMargin,
      defaultBorderRadius: defaultBorderRadius ?? this.defaultBorderRadius,
      defaultColor: defaultColor ?? this.defaultColor,
    );
  }

  @override
  ThemeExtension<ContainerTheme> lerp(
      ThemeExtension<ContainerTheme>? other, double t) {
    if (other is! ContainerTheme) {
      return this;
    }
    return ContainerTheme(
      defaultPadding:
          EdgeInsetsGeometry.lerp(defaultPadding, other.defaultPadding, t)!,
      defaultMargin:
          EdgeInsetsGeometry.lerp(defaultMargin, other.defaultMargin, t)!,
      defaultBorderRadius:
          BorderRadius.lerp(defaultBorderRadius, other.defaultBorderRadius, t)!,
      defaultColor: Color.lerp(defaultColor, other.defaultColor, t)!,
    );
  }
}

/// Extension to easily access ContainerTheme from ThemeData
extension ContainerThemeExtension on ThemeData {
  ContainerTheme get containerTheme => extension<ContainerTheme>()!;
}

/// StyledContainer is a custom widget that applies the ContainerTheme
class StyledContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Color? color;
  final double? elevation;

  const StyledContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.color,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final containerTheme = Theme.of(context).containerTheme;

    return Container(
      padding: padding ?? containerTheme.defaultPadding,
      margin: margin ?? containerTheme.defaultMargin,
      decoration: BoxDecoration(
        color: color ?? containerTheme.defaultColor,
        borderRadius: borderRadius ?? containerTheme.defaultBorderRadius,
      ),
      child: child,
    );
  }
}


// Add these examples at the end of the theme.dart file

/// This example demonstrates how to use the AppTheme in a Flutter application.
/// It sets up the MaterialApp with light and dark themes from AppTheme.
// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Theme Example App',
//       theme: AppTheme.lightTheme,
//       darkTheme: AppTheme.darkTheme,
//       themeMode: ThemeMode.system, // Use system theme mode
//       home: MyHomePage(),
//     );
//   }
// }

/// MyHomePage showcases various themed components and text styles.
/// It demonstrates how the theme is applied to different widgets.
// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Theme Example'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Example of StyledContainer usage
//             StyledContainer(
//               child: Text('This is a styled container'),
//             ),

//             // Various button types with themed appearances
//             ElevatedButton(
//               onPressed: () {},
//               child: Text('Elevated Button'),
//             ),
//             FilledButton(
//               onPressed: () {},
//               child: Text('Filled Button'),
//             ),
//             OutlinedButton(
//               onPressed: () {},
//               child: Text('Outlined Button'),
//             ),
//             TextButton(
//               onPressed: () {},
//               child: Text('Text Button'),
//             ),

//             // Other themed components
//             Switch(
//               value: true,
//               onChanged: (bool value) {},
//             ),
//             Checkbox(
//               value: true,
//               onChanged: (bool? value) {},
//             ),
//             Slider(
//               value: 0.5,
//               onChanged: (double value) {},
//             ),

//             // TextField with themed decoration
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Input Field',
//                 hintText: 'Enter text here',
//               ),
//             ),

//             SizedBox(height: 20),

//             // Text style examples
//             Text('Text Style Examples:', style: AppTheme.headlineMedium),
//             Text('Display Large', style: AppTheme.displayLarge),
//             Text('Display Medium', style: AppTheme.displayMedium),
//             Text('Display Small', style: AppTheme.displaySmall),
//             Text('Headline Large', style: AppTheme.headlineLarge),
//             Text('Headline Medium', style: AppTheme.headlineMedium),
//             Text('Headline Small', style: AppTheme.headlineSmall),
//             Text('Title Large', style: AppTheme.titleLarge),
//             Text('Title Medium', style: AppTheme.titleMedium),
//             Text('Title Small', style: AppTheme.titleSmall),
//             Text('Body Large', style: AppTheme.bodyLarge),
//             Text('Body Medium', style: AppTheme.bodyMedium),
//             Text('Body Small', style: AppTheme.bodySmall),
//             Text('Label Large', style: AppTheme.labelLarge),
//             Text('Label Medium', style: AppTheme.labelMedium),
//             Text('Label Small', style: AppTheme.labelSmall),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: Icon(Icons.add),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
//           BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
//         ],
//       ),
//     );
//   }
// }

/// This example shows how to use the ContainerTheme extension directly.
/// It creates a container with default theme properties.
// class ThemedContainerExample extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final containerTheme = Theme.of(context).containerTheme;

//     return Container(
//       padding: containerTheme.defaultPadding,
//       margin: containerTheme.defaultMargin,
//       decoration: BoxDecoration(
//         color: containerTheme.defaultColor,
//         borderRadius: containerTheme.defaultBorderRadius,
//       ),
//       child: Text('This container uses the default ContainerTheme'),
//     );
//   }
// }

/// TextStyleShowcase demonstrates how to use various text styles
/// in a more realistic scenario, creating a hierarchical layout.
// class TextStyleShowcase extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Main title using display style
//         Text('Welcome to Our App', style: AppTheme.displayLarge),
//         SizedBox(height: 10),

//         // Subtitle using headline style
//         Text('Explore Amazing Features', style: AppTheme.headlineMedium),
//         SizedBox(height: 20),

//         // Section title
//         Text('About Us', style: AppTheme.titleLarge),
//         // Body text
//         Text(
//           'We are a team of dedicated professionals working to bring you the best experience.',
//           style: AppTheme.bodyMedium,
//         ),
//         SizedBox(height: 20),

//         // Another section with a list
//         Text('Our Services', style: AppTheme.titleMedium),
//         Text('1. Web Development', style: AppTheme.bodyLarge),
//         Text('2. Mobile App Design', style: AppTheme.bodyLarge),
//         Text('3. UI/UX Consulting', style: AppTheme.bodyLarge),
//         SizedBox(height: 20),

//         // Contact information using different text styles
//         Text('Get in Touch', style: AppTheme.labelLarge),
//         Text('info@example.com', style: AppTheme.bodySmall),
//         Text('+1 (123) 456-7890', style: AppTheme.bodySmall),
//       ],
//     );
//   }
// }