import 'package:bdaya_firebase_helpers/src/models/json_based_object.dart';

class MapObject implements JsonBasedObject {
  Map<String, dynamic> _data;
  Map<String, dynamic> get data => _data ??= {};

  final String field;

  MapObject.fromMap(this.field, Map<String, dynamic> src) : _data = src[field];
  MapObject.fromDataMap(this.field, Map<String, dynamic> src) : _data = src;
}

extension MapObjectExt on Map<String, dynamic> {
  Map<String, TVal> getMap<TVal>(String key) {
    return this[key];
  }

  Map<String, T> toObjMap<T>(
      T Function(String key, Map<String, dynamic> src) con) {
    return this.map<String, T>((key, value) => MapEntry(key, con(key, value)));
  }

  Map<String, T> getMapThenToObjMap<T>(
      String key, T Function(String key, Map<String, dynamic> src) con) {
    final v = this[key];
    if (v == null) return null;
    return (v as Map<String, dynamic>).toObjMap<T>(con);
  }
}
