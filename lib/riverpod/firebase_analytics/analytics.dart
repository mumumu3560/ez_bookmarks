import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics.g.dart';

@riverpod
class AnalyticsNotifier extends _$AnalyticsNotifier {

  @override
  Future<FirebaseAnalytics> build() async{
    return FirebaseAnalytics.instance;
  }

  Future<void> onEventOccur(String name) async{
    await FirebaseAnalytics.instance.logEvent(
      name: '${name}が発生しました',
    );
  }

  





}