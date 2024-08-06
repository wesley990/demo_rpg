import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance.collection('characters') as FirebaseFirestore;

  // Singleton instance
  static final FirestoreService _instance = FirestoreService._internal();

  factory FirestoreService() {
    return _instance;
  }

  FirestoreService._internal();

  // Function to get a reference to a collection
  CollectionReference<Map<String, dynamic>> getCollection(
      String collectionName) {
    return _firestore.collection(collectionName);
  }

  // Function to get a document reference
  DocumentReference<Map<String, dynamic>> getDocument(
      String collectionName, String documentId) {
    return _firestore.collection(collectionName).doc(documentId);
  }

  // Function to add a new document to a collection
  Future<void> addDocument(String collectionName, Map<String, dynamic> data) {
    return _firestore.collection(collectionName).add(data);
  }

  // Function to update an existing document
  Future<void> updateDocument(
      String collectionName, String documentId, Map<String, dynamic> data) {
    return _firestore.collection(collectionName).doc(documentId).update(data);
  }

  // Function to delete a document
  Future<void> deleteDocument(String collectionName, String documentId) {
    return _firestore.collection(collectionName).doc(documentId).delete();
  }
}
