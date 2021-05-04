import 'package:bdaya_firebase_helpers/bdaya_firebase_helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// helps with the creation of FirestoreDocumentBase and auto merges nested streams
abstract class FirestoreHelperService {
  final objectCache = <String, FirestoreDocumentBase>{};
  T getOrCreateFirestoreObject<T extends FirestoreDocumentBase>(
    DocumentSnapshot doc,
    T create(DocumentSnapshot snap),
  ) {
    final v = objectCache[doc.reference.path];
    if (v == null) {
      return objectCache[doc.reference.path] = create(doc);
    } else {
      return v as T;
    }
  }

  void deleteFirestoreRef(String path) {
    objectCache.remove(path);
  }
}
