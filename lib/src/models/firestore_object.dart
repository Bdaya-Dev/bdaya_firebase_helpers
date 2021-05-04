import 'package:bdaya_firebase_helpers/src/models/json_based_object.dart';

/// A base class for all firestore objects (for nested map objects, use [MapObject])
abstract class FirestoreDocumentBase implements JsonBasedObject {
  final String path;
  final String id;

  FirestoreDocumentBase({
    required this.path,
    required this.id,
  });

  void fromJson({
    required String path,
    required Map<String, dynamic> data,
  });
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FirestoreDocumentBase && other.path == other.path;
  }

  @override
  int get hashCode => path.hashCode;
}
