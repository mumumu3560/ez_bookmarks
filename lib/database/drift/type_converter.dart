import 'dart:convert';
import 'package:drift/drift.dart';

class TagListConverter extends TypeConverter<List<String>, String> {
  const TagListConverter();

  @override
  List<String> fromSql(String fromDb) {
    // fromDbはnull非許容。空文字列の場合は空のリストを返す。
    if (fromDb.isEmpty) return [];
    return List<String>.from(json.decode(fromDb));
  }

  @override
  String toSql(List<String> value) {
    // valueはnull非許容。空のリストの場合は空文字列をJSONエンコードして返す。
    return json.encode(value);
  }
}
