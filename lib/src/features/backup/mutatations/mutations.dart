import 'package:sqflite/sqflite.dart';

Future<void> insertList(
    Batch db, String tableName, List<Map<String, dynamic>> values) async {
  for (var val in values) {
    db.insert(tableName, val, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
