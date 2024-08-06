import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();

  factory FirestoreService() {
    return _instance;
  }

  FirestoreService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> getCollection(
      String collectionName) {
    return _firestore.collection(collectionName);
  }

  DocumentReference<Map<String, dynamic>> getDocument(
      String collectionName, String documentId) {
    return _firestore.collection(collectionName).doc(documentId);
  }

  Future<DocumentReference<Map<String, dynamic>>> addDocument(
      String collectionName, Map<String, dynamic> data) {
    return _firestore.collection(collectionName).add(data);
  }

  Future<void> updateDocument(
      String collectionName, String documentId, Map<String, dynamic> data) {
    return _firestore.collection(collectionName).doc(documentId).update(data);
  }

  Future<void> deleteDocument(String collectionName, String documentId) {
    return _firestore.collection(collectionName).doc(documentId).delete();
  }
}
