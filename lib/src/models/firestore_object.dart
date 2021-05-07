import 'package:cloud_firestore/cloud_firestore.dart';

/// A base class for all firestore objects (for nested map objects, use [MapObject])
abstract class FirestoreDocumentBase {
  DocumentReference<Map<String, dynamic>>? _ref;
  DocumentReference<Map<String, dynamic>> get reference =>
      _ref ??= FirebaseFirestore.instance.doc(path);

  final String path;
  final String id;

  FirestoreDocumentBase({
    required this.path,
    required this.id,
    Map<String, dynamic>? data,
  }) {
    if (data != null) {
      fromJson(data);
    }
  }

  FirestoreDocumentBase.withSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot)
      : _ref = snapshot.reference,
        path = snapshot.reference.path,
        id = snapshot.id {
    final data = snapshot.data();
    if (data != null) {
      fromJson(data);
    }
  }

  void fromJson(Map<String, dynamic> data);
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FirestoreDocumentBase && other.path == other.path;
  }

  @override
  int get hashCode => path.hashCode;
}
