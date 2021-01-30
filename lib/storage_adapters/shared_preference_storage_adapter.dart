import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_image_editor/storage_adapters/base_storage_adapter.dart';

class SharedPreferenceStorageAdapter extends BaseStorageAdapter {
  SharedPreferenceStorageAdapter();

  Future<String> readString({@required String key}) async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  Future<void> writeString({@required String key, @required String value}) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  Future<void> delete({@required String key}) async {
    var pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }
}
