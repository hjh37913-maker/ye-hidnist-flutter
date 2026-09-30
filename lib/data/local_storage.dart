import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static Future<Box> box() => Hive.openBox('ye_hidnist');
  static Future<void> setSession(Map<String,dynamic> session) async => (await box()).put('session', jsonEncode(session));
  static Future<Map<String,dynamic>?> session() async {
    final raw = (await box()).get('session');
    if (raw == null) return null;
    return Map<String,dynamic>.from(jsonDecode(raw));
  }
  static Future<void> clearSession() async => (await box()).delete('session');
}
