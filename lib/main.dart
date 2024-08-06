import 'package:demo_rpg/screens/home/home.dart';
import 'package:demo_rpg/services/character_store.dart';
import 'package:demo_rpg/services/firestore_service.dart';
import 'package:demo_rpg/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    FirestoreService.enablePersistence();
  } catch (e) {
    print('Error enabling persistence: $e');
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CharacterStore(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const SelectableRegionExample(),
      ),
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
