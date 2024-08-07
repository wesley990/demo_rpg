import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_rpg/models/character.dart';
import 'package:demo_rpg/models/vocation.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final charactersRef =
      _firestore.collection('characters').withConverter<Character>(
            fromFirestore: Character.fromFirestore,
            toFirestore: (Character c, _) => c.toFirestore(),
          );

  // CRUD operations
  static Future<void> addCharacter(Character character) {
    return handleFirestoreError(() async {
      // await charactersRef.add(character);
      await charactersRef
          .doc(character.id)
          .set(character); // since we use uuid v4 as id
    });
  }

  static Future<Character?> getCharacter(String id) async {
    return handleFirestoreError(() async {
      final doc = await charactersRef.doc(id).get();
      return doc.data();
    });
  }

  static Future<QuerySnapshot<Character>> getCharacterOnce() {
    return handleFirestoreError(() async {
      return await charactersRef.get();
    });
  }

  static Future<void> updateCharacter(Character character) {
    return handleFirestoreError(() async {
      await charactersRef
          .doc(character.id)
          // .set(character, SetOptions(merge: true));
          .update({
        'stats': character.statsAsMap,
        'points': character.points,
        'isFavorite': character.isFavorite,
        'skills': character.skills.map((skill) => skill.id).toList(),
      });
    });
  }

  static Future<void> deleteCharacter(Character character) {
    return handleFirestoreError(() async {
      await charactersRef.doc(character.id).delete();
    });
  }

  // Query operations
  static Stream<List<Character>> getCharactersByVocation(Vocation vocation) {
    return charactersRef
        .where('vocation', isEqualTo: vocation.toString())
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  static Future<List<Character>> getFavoriteCharacters() async {
    return handleFirestoreError(() async {
      final querySnapshot =
          await charactersRef.where('isFavorite', isEqualTo: true).get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  // Batch operations
  static Future<void> batchUpdateCharacters(List<Character> characters) {
    return handleFirestoreError(() async {
      final batch = _firestore.batch();
      for (var character in characters) {
        batch.set(charactersRef.doc(character.id), character,
            SetOptions(merge: true));
      }
      await batch.commit();
    });
  }

  // Transaction example
  static Future<void> transferSkill(
      String fromCharacterId, String toCharacterId, String skillId) {
    return handleFirestoreError(() async {
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
  static void enablePersistence() {
    try {
      _firestore.settings = const Settings(
          persistenceEnabled: true,
          cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
      if (kDebugMode) {
        print('Firestore persistence enabled');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error enabling Firestore persistence: $e');
      }
      // You might want to set some flag or notify the user here
    }
  }

  // Error handling
  static Future<T> handleFirestoreError<T>(
      Future<T> Function() operation) async {
    try {
      return await operation();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Firestore error: ${e.code} - ${e.message}');
      }
      // You could also use a more sophisticated error handling mechanism here
      rethrow;
    }
  }
}
