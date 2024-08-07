import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_rpg/models/character.dart';
import 'package:demo_rpg/models/vocation.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  FirestoreService._() {
    _initializeFirestore();
  }
  static final FirestoreService instance = FirestoreService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final CollectionReference<Character> charactersRef;

  void _initializeFirestore() {
    charactersRef =
        _firestore.collection('characters').withConverter<Character>(
              fromFirestore: Character.fromFirestore,
              toFirestore: (Character c, _) => c.toFirestore(),
            );
  }

  // CRUD operations
  Future<void> addCharacter(Character character) {
    return _handleFirestoreError(() async {
      await charactersRef.doc(character.id).set(character);
    });
  }

  Future<Character?> getCharacter(String id) async {
    return _handleFirestoreError(() async {
      final doc = await charactersRef.doc(id).get();
      return doc.data();
    });
  }

  Future<List<Character>> getAllCharacters() {
    return _handleFirestoreError(() async {
      final snapshot = await charactersRef.get();
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> updateCharacter(Character character) {
    return _handleFirestoreError(() async {
      await charactersRef.doc(character.id).update({
        'stats': character.statsAsMap,
        'points': character.points,
        'isFavorite': character.isFavorite,
        'skills': character.skills.map((skill) => skill.id).toList(),
      });
    });
  }

  Future<void> deleteCharacter(String characterId) {
    return _handleFirestoreError(() async {
      await charactersRef.doc(characterId).delete();
    });
  }

  // Query operations
  Stream<List<Character>> getCharactersByVocation(Vocation vocation) {
    return charactersRef
        .where('vocation', isEqualTo: vocation.toString())
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<List<Character>> getFavoriteCharacters() async {
    return _handleFirestoreError(() async {
      final querySnapshot =
          await charactersRef.where('isFavorite', isEqualTo: true).get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  // Batch operations
  Future<void> batchUpdateCharacters(List<Character> characters) {
    return _handleFirestoreError(() async {
      final batch = _firestore.batch();
      for (var character in characters) {
        batch.set(charactersRef.doc(character.id), character,
            SetOptions(merge: true));
      }
      await batch.commit();
    });
  }

  // Transaction example
  Future<void> transferSkill(
      String fromCharacterId, String toCharacterId, String skillId) {
    return _handleFirestoreError(() async {
      await _firestore.runTransaction((transaction) async {
        final fromCharacterDoc = charactersRef.doc(fromCharacterId);
        final toCharacterDoc = charactersRef.doc(toCharacterId);

        final fromCharacter = (await transaction.get(fromCharacterDoc)).data();
        final toCharacter = (await transaction.get(toCharacterDoc)).data();

        if (fromCharacter == null || toCharacter == null) {
          throw Exception('One or both characters not found');
        }

        final skill = fromCharacter.skills.firstWhere((s) => s.id == skillId,
            orElse: () => throw Exception('Skill not found'));

        fromCharacter.skills.remove(skill);
        toCharacter.skills.add(skill);

        transaction.set(fromCharacterDoc, fromCharacter);
        transaction.set(toCharacterDoc, toCharacter);
      });
    });
  }

  // Offline persistence
  void enablePersistence() {
    try {
      _firestore.settings = const Settings(
        persistenceEnabled: true,
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
      );
      if (kDebugMode) {
        print('Firestore persistence enabled');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error enabling Firestore persistence: $e');
      }
      // Consider implementing a more robust error handling mechanism
    }
  }

  // Error handling
  Future<T> _handleFirestoreError<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Firestore error: ${e.code} - ${e.message}');
      }
      // Consider implementing a more sophisticated error handling mechanism
      rethrow;
    }
  }
}
