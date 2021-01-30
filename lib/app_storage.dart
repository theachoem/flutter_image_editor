import 'package:flutter_image_editor/constants/api_constant.dart';
import 'package:flutter_image_editor/storages/storages.dart';
import 'package:flutter_image_editor/types/app_env_type.dart';

class AppStorage {
  static BaseStorageAdapter _preferenceAdapter;
  static BaseStorageAdapter _secureAdapter;

  ///```
  /// _preferenceAdapter = MemoryStorageAdapter();
  /// _preferenceAdapter = SharedPreferenceStorageAdapter();
  /// ```
  static BaseStorageAdapter get preferenceAdapter {
    if (_preferenceAdapter != null) return _preferenceAdapter;
    _preferenceAdapter = SharedPreferenceStorageAdapter();
    return _preferenceAdapter;
  }

  static set preferenceAdapter(BaseStorageAdapter storageAdapter) {
    _preferenceAdapter = storageAdapter;
  }

  ///```
  ///_secureAdapter = SharedPreferenceStorageAdapter();
  ///_secureAdapter = SecureStorageAdapter();
  ///_secureAdapter = MemoryStorageAdapter();
  ///```
  static BaseStorageAdapter get secureAdapter {
    if (_secureAdapter != null) return _secureAdapter;
    if (ApiConstant.env != AppEnvType.production) {
      _secureAdapter = SharedPreferenceStorageAdapter();
    } else {
      _secureAdapter = SecureStorageAdapter();
    }
    return _secureAdapter;
  }

  static set secureAdapter(BaseStorageAdapter storageAdapter) {
    _secureAdapter = storageAdapter;
  }
}
