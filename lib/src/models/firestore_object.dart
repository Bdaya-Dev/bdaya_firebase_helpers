import 'dart:async';

import 'package:bdaya_firebase_helpers/src/models/json_based_object.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_ref_wrapper.dart';

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
}
