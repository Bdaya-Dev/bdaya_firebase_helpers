import 'package:bdaya_firebase_helpers/src/models/exports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

extension FirestoreDocumentQueryExt on Stream<DocumentSnapshot> {
  /// Maps the stream to an object of type T using a constructor
  Stream<T> toHelperObject<T extends FirestoreDocumentBase>(
    T Function(DocumentSnapshot doc) createObject,
  ) {
    return this.map<T>((docSnap) => createObject(docSnap));
  }
}
