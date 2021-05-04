import 'package:bdaya_firebase_helpers/src/models/json_based_object.dart';

class MapObject implements JsonBasedObject {
  Map<String, dynamic>? _data;
  Map<String, dynamic> get data => _data ??= {};

  final String field;
  MapObject.fromDataMap(this.field, Map<String, dynamic> src) : _data = src;
}
