import 'package:shared_preferences/shared_preferences.dart';

abstract class ThirdPartyModule {
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
