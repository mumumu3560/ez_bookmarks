import 'package:ez_bookmarks/riverpod/db_admin/db_admin.dart';
import 'package:ez_bookmarks/riverpod/db_switcher/db_switcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> performDatabaseSwitch(String dbValue, WidgetRef ref) async {
  final notifier = ref.read(dbSwitcherNotifierProvider.notifier);
  notifier.updateState(dbValue);

  final dbAdNotifier = ref.read(dbAdminNotifierProvider.notifier);
  await dbAdNotifier.closeDB();
  await dbAdNotifier.updateDB(dbValue);
}


//GDPRの同意メッセージの表示
Future<void> changePrivacyPreferences() async{
  ConsentInformation.instance
      .requestConsentInfoUpdate(ConsentRequestParameters(), () async {
    if (await ConsentInformation.instance.isConsentFormAvailable()) {
      ConsentForm.loadConsentForm((consentForm) {
        consentForm.show((formError) async {
        });
      }, (formError) {
      });
    }
  }, (error) {
  });
}