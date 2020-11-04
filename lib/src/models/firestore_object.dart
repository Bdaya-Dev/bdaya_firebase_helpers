import 'dart:async';

import 'package:bdaya_firebase_helpers/src/models/json_based_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreDocumentHelper implements JsonBasedObject {
  Map<String, dynamic> _data;
  Map<String, dynamic> get data => _data ??= {};

  bool _exists; // => snapshot.exists;
  bool get exists => _exists;

  final String path; // => snapshot.reference.path;
  String get id => reference.id;

  DocumentReference _reference;
  DocumentReference get reference =>
      _reference ??= FirebaseFirestore.instance.doc(path);

  Future<void> save() => reference.update(data);

  Future<void> createOrUpdate() => reference.set(data, SetOptions(merge: true));

  FirestoreDocumentHelper(DocumentSnapshot __snapshot)
      : _data = __snapshot.data(),
        path = __snapshot.reference.path,
        _exists = __snapshot.exists;

  FirestoreDocumentHelper.fromMap(
    this.path, {
    bool exists = true,
    @required Map<String, dynamic> data,
  })  : _exists = exists,
        _data = data;

  

  @override
  String toString() =>
      'FirestoreDocumentHelper(_data: $_data, _reference: $_reference)';
}

extension FirestoreObjectQueryExt on Stream<QuerySnapshot> {
  Stream<Iterable<T>> toHelperIterable<T extends FirestoreDocumentHelper>(
      T Function(DocumentSnapshot) createObject) {
    return this.map<Iterable<T>>(
        (querySnap) => querySnap.docs.map<T>((f) => createObject(f)));
  }

  Stream<List<T>> toHelperList<T extends FirestoreDocumentHelper>(
      T Function(DocumentSnapshot) createObject) {
    return this.map<Iterable<T>>(
        (querySnap) => querySnap.docs.map<T>((f) => createObject(f)).toList());
  }

  Stream<Map<String, T>> toHelperMap<T extends FirestoreDocumentHelper>(
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

extension FirestoreObjectDocumentExt on Stream<DocumentSnapshot> {
  Stream<T> toHelperObject<T extends FirestoreDocumentHelper>(
      T Function(DocumentSnapshot) createObject) {
    return this.map<T>((docSnap) => createObject(docSnap));
  }
}
