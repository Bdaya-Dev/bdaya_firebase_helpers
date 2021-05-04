import 'dart:async';

import 'package:bdaya_firebase_helpers/bdaya_firebase_helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ext/exports.dart';

class FirestoreRefWrapper<T extends FirestoreDocumentBase> {
  final DocumentReference ref;
  final T Function(DocumentSnapshot snap) createObject;
  FirestoreRefWrapper({
    required this.ref,
    required this.createObject,
  });

  T? latestData;
  DocumentSnapshot? latestSnapshot;

  Stream<T> snapshots({bool includeMetadataChanges = false}) => ref
      .snapshots(includeMetadataChanges: includeMetadataChanges)
      .toHelperObject(createObject);

  StreamSubscription<DocumentSnapshot> listenForCache({
    bool includeMetadataChanges = false,
  }) {
    return ref.snapshots(includeMetadataChanges: includeMetadataChanges).listen(
      (event) {
        latestSnapshot = event;
        latestData = createObject(event);
      },
    );
  }
}
