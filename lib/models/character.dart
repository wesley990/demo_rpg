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
