import 'package:flutter_image_editor/app_storage.dart';

abstract class BaseStorage {
  Future<Map<String, dynamic>> read() {
    return AppStorage.secureAdapter.readObject(key: key());
  }

  write(Map<String, dynamic> value) async {
    await AppStorage.secureAdapter.writeObject(key: key(), value: value);
  }

  clear() async {
    await AppStorage.secureAdapter.delete(key: key());
  }

  String key();
}
