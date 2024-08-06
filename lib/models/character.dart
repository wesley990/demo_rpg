import 'package:cloud_firestore/cloud_firestore.dart';
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
  void updateSkill(Skill skill) {
    skills.clear();
    skills.add(skill);
  }

  // character to firestore (map)
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'slogan': slogan,
      'id': id,
      'vocation': vocation.toString(),
      'isFavorite': _isFavorite,
      'skills': skills.map((skill) => skill.id).toList(),
      'stats': statsAsListOfMap,
    };
  }

  factory Character.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    if (data == null) {
      throw Exception('No data found in the snapshot');
    }

    Character character = Character(
      name: data['name'] as String? ?? '',
      slogan: data['slogan'] as String? ?? '',
      id: data['id'] as String? ?? '',
      vocation: Vocation.values.firstWhere(
        (v) =>
            v.toString() ==
            'Vocation.${data['vocation'] as String? ?? 'unknown'}',
        orElse: () => Vocation.unknown,
      ),
      isFavorite: data['isFavorite'] as bool? ?? false,
    );

    for (String id in data['skills'] as List<String>) {
      Skill skill = allSkills.firstWhere((skill) => skill.id == id);

      character.updateSkill(skill);
    }

    return character;
  }
}
