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

  List<T> syncCacheWithIterableDocs<T extends FirestoreDocumentBase>(
    Iterable<DocumentChange> changes,
    T create(DocumentSnapshot snap),
  ) {
    final res = <T>[];

    for (var c in changes) {
      switch (c.type) {
        case DocumentChangeType.added:
        case DocumentChangeType.modified:
          //doesn't exist before
          var prev = objectCache[c.doc.reference.path];
          if (prev == null || !(prev is T)) {
            objectCache[c.doc.reference.path] = prev = create(c.doc);
          } else {
            //prev.data = c.doc.data()!;
          }
          res.add(prev);
          break;
        case DocumentChangeType.removed:
          objectCache.remove(c.doc.reference.path);
          break;
        default:
      }
    }
    return res;
  }

  void deleteFirestoreRef(String path) {
    objectCache.remove(path);
  }
}
