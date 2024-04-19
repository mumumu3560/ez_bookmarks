import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _dbNameKey = 'database_name';

  Future<void> saveDatabaseName(String dbName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dbNameKey, dbName);
  }

  Future<String> loadDatabaseName() async {
    final prefs = await SharedPreferences.getInstance();
    // デフォルトのデータベース名を設定
    return prefs.getString(_dbNameKey) ?? 'ez_database.sqlite';
  }
}
