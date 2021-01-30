import 'package:flutter/material.dart';
import 'package:flutter_image_editor/storage_adapters/base_storage_adapter.dart';

class MemoryStorageAdapter extends BaseStorageAdapter {
  Map<String, String> data = {};
  Future<String> readString({@required String key}) async {
    return data[key];
  }

  Future<void> writeString({@required String key, @required String value}) async {
    data[key] = value;
  }

  Future<void> delete({@required String key}) async {
    data[key] = null;
  }

  void reset() {
    data = {};
  }
}
