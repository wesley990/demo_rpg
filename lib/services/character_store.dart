import 'package:demo_rpg/services/firestore_service.dart';
import 'package:flutter/foundation.dart';
import 'package:demo_rpg/models/character.dart';

class CharacterStore extends ChangeNotifier {
  final List<Character> _characters = [];

  List<Character> get characters => _characters;

  void addCharacter(Character character) {
    FirestoreService.addCharacter(character);
    _characters.add(character);
    notifyListeners();
  }

  Future<void> saveCharacter(Character character) async {
    await FirestoreService.updateCharacter(character);
    return;
  }

  void removeCharacter(String id) {
    _characters.removeWhere((character) => character.id == id);
    notifyListeners();
  }

  void updateCharacter(Character updatedCharacter) {
    final index = _characters
        .indexWhere((character) => character.id == updatedCharacter.id);
    if (index != -1) {
      _characters[index] = updatedCharacter;
      FirestoreService.updateCharacter(updatedCharacter);
      notifyListeners();
    }
  }

  void clearCharacters() {
    _characters.clear();
    notifyListeners();
  }

  void fecthCharacterOnce() async {
    if (characterCount > 0) {
      return;
    } else {
      final snapshot = await FirestoreService.getCharacterOnce();
      _characters.addAll(snapshot.docs.map((doc) => doc.data()).toList());
      notifyListeners();
    }
  }

  int get characterCount => _characters.length;

  bool get hasCharacters => _characters.isNotEmpty;
}
