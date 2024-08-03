import 'package:demo_rpg/models/skill.dart';
import 'package:demo_rpg/models/stats.dart';
import 'package:demo_rpg/models/vocation.dart';

// Using a mixin to add functionality from Stats
class Character with Stats {
  // Using 'final' for immutable properties
  final String name;
  final String slogan;
  final String id;
  final Vocation vocation;
  final Set<Skill> skills = {};

  // Private field for encapsulation
  bool _isFavorite;

  // Constructor with named parameters and default value
  // Using an initializer list for _isFavorite
  Character({
    required this.name,
    required this.slogan,
    required this.id,
    required this.vocation,
    bool isFavorite = false,
  }) : _isFavorite = isFavorite;

  // Getter for read-only access to private field
  bool get isFavorite => _isFavorite;

  // Method to modify private field
  void toggleFavorite() {
    _isFavorite = !_isFavorite;
  }

  // Override toString() for custom string representation
  // Using multi-line string literal for improved readability
  @override
  String toString() => '''
    Character: $name
    Slogan: $slogan
    ID: $id
    Is Favorite: $_isFavorite
  ''';

  // Implementing custom equality
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Character &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          id == other.id;

  // Implementing hashCode for consistency with equals
  @override
  int get hashCode => name.hashCode ^ id.hashCode;

  // update skill set
  void updateSkills(Set<Skill> newSkills) {
    skills.clear();
    skills.addAll(newSkills);
  }
}

List<Character> characters = [
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
