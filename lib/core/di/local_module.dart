import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/local/app_preferences.dart';

@module
abstract class LocalModule {
  @singleton
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  AppPreferences appPreferences(SharedPreferences prefs) =>
      AppPreferences(prefs);
}