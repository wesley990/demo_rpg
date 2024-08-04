import 'package:demo_rpg/home/home.dart';
import 'package:demo_rpg/home/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SelectableRegionExample(),
    );
  }
}

class SelectableRegionExample extends StatelessWidget {
  const SelectableRegionExample({super.key});

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    return Scaffold(
      body: Center(
        child: SelectableRegion(
          selectionControls: materialTextSelectionControls,
          focusNode: focusNode,
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
