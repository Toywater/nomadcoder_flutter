import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:navigation_time_challenge12/models/user_config_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserConfigVM extends Notifier<UserConfigModel> {
  UserConfigVM(this._preferences) {
    _model = UserConfigModel(_preferences);
  }

  late UserConfigModel _model;
  final SharedPreferences _preferences;

  // 노출된 프로퍼티들
  bool get isDarkMode => _model.isDarkMode;

  Future<void> setIsDarkMode(bool value) async {
    await _model.setIsDarkMode(value);

    state = UserConfigModel(_preferences);
  }

  @override
  UserConfigModel build() {
    return UserConfigModel(_preferences);
  }
}

final userConfigProvider = NotifierProvider<UserConfigVM, UserConfigModel>(
  () => throw UnimplementedError(),
);
