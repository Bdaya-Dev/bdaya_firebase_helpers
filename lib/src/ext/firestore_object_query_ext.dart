import 'package:bdaya_firebase_helpers/src/models/exports.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

extension FirestoreObjectQueryExt on Stream<QuerySnapshot> {
  Stream<Iterable<T>> toHelperIterable<T extends FirestoreDocumentBase>(
    T Function(DocumentSnapshot) createObject,
  ) {
    return this.map<Iterable<T>>(
        (querySnap) => querySnap.docs.map<T>((f) => createObject(f)));
  }

  Stream<List<T>> toHelperList<T extends FirestoreDocumentBase>(
    T Function(DocumentSnapshot) createObject,
  ) {
    return this.map<List<T>>(
      (querySnap) => querySnap.docs.map<T>((f) => createObject(f)).toList(),
    );
  }

  Stream<Map<String, T>> toHelperMapPath<T extends FirestoreDocumentBase>(
          T Function(DocumentSnapshot) createObject) =>
      this.map<Map<String, T>>(
        (event) => Map.fromEntries(
          event.docs.map(
            (e) => MapEntry(
              e.reference.path,
              createObject(e),
            ),
          ),
        ),
      );

  Stream<Map<String, T>> toHelperMap<T extends FirestoreDocumentBase>(
          T Function(DocumentSnapshot) createObject) =>
      this.map<Map<String, T>>(
        (event) => Map.fromEntries(
          event.docs.map(
            (e) => MapEntry(
              e.reference.id,
              createObject(e),
            ),
          ),
        ),
      );
}
