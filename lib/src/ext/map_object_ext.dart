import 'package:bdaya_firebase_helpers/src/models/exports.dart';

extension MapObjectExt on MapObject {
  static MapObject fromParentMap(String field, Map<String, dynamic> parentSrc) {
    return MapObject.fromDataMap(field, parentSrc[field]);
  }
}

extension MapToMapObjectExt on Map<String, dynamic> {
  Map<String, TVal> getMap<TVal>(
    String key, {
    Map<String, TVal> Function()? defaultValue,
  }) {
    final v1 = this[key];
    if (v1 is Map<String, dynamic>) {
      return v1.cast<String, TVal>();
    }
    return defaultValue?.call() ?? <String, TVal>{};
  }

  Map<String, T> toObjMap<T>(
    T Function(String key, Map<String, dynamic> src) con,
  ) {
    return this.map<String, T>((key, value) => MapEntry(key, con(key, value)));
  }

  Map<String, T>? getMapThenToObjMap<T>(
    String key,
    T Function(String key, Map<String, dynamic> src) con,
  ) {
    final v = this[key];
    if (v == null || !(v is Map<String, dynamic>)) return null;
    return v.toObjMap<T>(con);
  }
}
