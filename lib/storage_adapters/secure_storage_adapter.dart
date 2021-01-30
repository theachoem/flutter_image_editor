import 'package:flutter/material.dart';
import 'package:flutter_image_editor/storage_adapters/base_storage_adapter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageAdapter extends BaseStorageAdapter {
  FlutterSecureStorage secureStorage;

  SecureStorageAdapter({FlutterSecureStorage secureStorage}) {
    secureStorage = FlutterSecureStorage();
  }

  Future<String> readString({@required String key}) async {
    return await this.secureStorage.read(key: key);
  }

  Future<void> writeString({@required String key, @required String value}) async {
    await this.secureStorage.write(key: key, value: value);
  }

  Future<void> delete({@required String key}) async {
    await this.secureStorage.delete(key: key);
  }
}
