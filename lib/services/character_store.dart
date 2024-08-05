import 'package:demo_rpg/models/vocation.dart';
import 'package:flutter/foundation.dart';
import 'package:demo_rpg/models/character.dart';

class CharacterStore extends ChangeNotifier {
  final List<Character> _characters = [
    Character(
      name: '艾爾德林·神秘法師',
      slogan: '奧術之道的至高主宰，掌控宇宙奧秘的智慧導師',
      id: '1',
      vocation: Vocation.mage,
    ),
    Character(
      name: '影刃·陰影刺客',
      slogan: '如夜色般靜謐，如陰影般致命，潛行於黑暗中的無形刺客',
      id: '2',
      vocation: Vocation.rogue,
    ),
    Character(
      name: '賽拉菲娜·光明使者',
      slogan: '神聖恩典的閃耀明燈，照亮世間黑暗、撫慰眾生之苦的聖潔天使',
      id: '3',
      vocation: Vocation.cleric,
    ),
    Character(
      name: '索爾加·鐵拳',
      slogan: '戰場上堅不可摧的鋼鐵意志，如山岳般屹立不倒的無畏勇士',
      id: '4',
      vocation: Vocation.warrior,
    ),
  ];

  List<Character> get characters => _characters;

  void addCharacter(Character character) {
    _characters.add(character);
    notifyListeners();
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
      notifyListeners();
    }
  }

  void clearCharacters() {
    _characters.clear();
    notifyListeners();
  }

  int get characterCount => _characters.length;

  bool get hasCharacters => _characters.isNotEmpty;
}
