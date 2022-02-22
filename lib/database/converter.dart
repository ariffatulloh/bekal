import 'package:moor/moor.dart';

class ArrayConverter<T> extends TypeConverter<List<T>, String> {
  @override
  List<T>? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    }

    return List<T>.from(fromDb.split(","));
  }

  @override
  String? mapToSql(List<T>? value) {
    if (value == null) {
      return null;
    }

    return value.toString();
  }
}
