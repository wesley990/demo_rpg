import 'package:demo_rpg/services/firestore_service.dart';
import 'package:flutter/foundation.dart';
import 'package:demo_rpg/models/character.dart';

class CharacterStore extends ChangeNotifier {
  final List<Character> _characters = [];
  List<Character> get characters => List.unmodifiable(_characters);

  Future<void> addCharacter(Character character) async {
    await FirestoreService.addCharacter(character);
    _characters.add(character);
    notifyListeners();
  }

  Future<void> saveCharacter(Character character) async {
    await FirestoreService.updateCharacter(character);
  }

  Future<void> removeCharacter(Character character) async {
    _characters.removeWhere((c) => character.id == c.id);
    await FirestoreService.deleteCharacter(character);
    notifyListeners();
  }

  Future<void> updateCharacter(Character updatedCharacter) async {
    final index = _characters
        .indexWhere((character) => character.id == updatedCharacter.id);
    if (index != -1) {
      _characters[index] = updatedCharacter;
      await saveCharacter(updatedCharacter);
      notifyListeners();
    }
  }

  void clearCharacters() {
    _characters.clear();
    notifyListeners();
  }

  Future<void> fetchCharactersOnce() async {
    if (_characters.isEmpty) {
      final snapshot = await FirestoreService.getCharacterOnce();
      _characters.addAll(snapshot.docs.map((doc) => doc.data()).toList());
      notifyListeners();
    }
  }

  int get characterCount => _characters.length;
  bool get hasCharacters => _characters.isNotEmpty;
}
