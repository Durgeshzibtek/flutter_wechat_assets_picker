import 'package:shared_preferences/shared_preferences.dart';

// ignore: avoid_classes_with_only_static_members
class StorageService {
  static Future<String?>? getStringValues() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? stringValue = prefs.getString('showPopup');
    return stringValue;
  }
}
