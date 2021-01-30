import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_image_editor/storages/bool_preference_storage.dart';

class FakeBoolStorage extends BoolPreferenceStorage {
  String key() {
    return 'fakeBool';
  }
}

void main() {
  SharedPreferences.setMockInitialValues({});
  var storage = FakeBoolStorage();

  tearDown(() async {
    await storage.reset();
  });

  group("setValue", () {
    test("it turns on if value is set to true", () async {
      await storage.setValue(true);
      bool result = await storage.on;
      expect(result, true);
    });

    test("it turns off if value is set to true", () async {
      await storage.setValue(false);
      bool result = await storage.off;
      expect(result, true);
    });
  });
  group('FakeBoolStorage#on', () {
    test('return false if it has not set', () async {
      bool result = await storage.on;
      expect(result, false);
    });

    test('return true if it set value', () async {
      await storage.setOn();
      bool result = await storage.on;
      expect(result, true);
    });
  });

  group("reset", () {
    test("it returns false after resetting", () async {
      await storage.setOn();
      await storage.reset();
      bool result = await storage.on;
      expect(result, false);
    });
  });
}
