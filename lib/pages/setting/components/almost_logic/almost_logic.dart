import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:ez_bookmarks/riverpod/db_switcher/db_switcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> performDatabaseSwitch(String dbValue, WidgetRef ref) async {
  final notifier = ref.read(dbSwitcherNotifierProvider.notifier);
  notifier.updateState(dbValue);

  final dbAdNotifier = ref.read(dbAdminNotifierProvider.notifier);
  await dbAdNotifier.closeDB();
  await dbAdNotifier.updateDB(dbValue);
}