import 'package:flutter_image_editor/storages/bool_preference_storage.dart';

class DarkThemeStorage extends BoolPreferenceStorage {
  String key() {
    return 'themeDarkMode';
  }
}
