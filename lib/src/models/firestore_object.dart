import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bdaya_firebase_helpers/src/models/json_based_object.dart';

/// A base class for all firestore objects (for nested map objects, use [MapObject])
class FirestoreDocumentBase implements JsonBasedObject {
  Map<String, dynamic>? _data;
  Map<String, dynamic> get data => _data ??= {};
  set data(Map<String, dynamic> map) {
    _data = map;
  }

  bool exists;

  final String path; // => snapshot.reference.path;
  String get id => reference.id;

  DocumentReference? _reference;
  DocumentReference get reference =>
      _reference ??= FirebaseFirestore.instance.doc(path);

  Future<void> save() => reference.update(data);

  Future<void> createOrUpdate() => reference.set(data, SetOptions(merge: true));

  FirestoreDocumentBase(DocumentSnapshot __snapshot)
      : _data = __snapshot.data(),
        path = __snapshot.reference.path,
        exists = __snapshot.exists;

  FirestoreDocumentBase.fromMap(
    this.path, {
    bool exists = true,
    required Map<String, dynamic> data,
  })  : exists = exists,
        _data = data;

  @override
  String toString() =>
      'FirestoreDocumentHelper(_data: $_data, _reference: $_reference)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FirestoreDocumentBase &&
        other.reference.path == other.reference.path;
  }

  @override
  int get hashCode => reference.path.hashCode;
}
