
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  static Future<SharedPreferences> _p() => SharedPreferences.getInstance();
  static Future<String> getLang() async => (await _p()).getString('lang') ?? 'de';
  static Future<void> setLang(String code) async => (await _p()).setString('lang', code);
  static Future<int> getOil() async => (await _p()).getInt('oil') ?? 50;
  static Future<void> setOil(int v) async => (await _p()).setInt('oil', v.clamp(0,100));
  static Future<String?> getHabits() async => (await _p()).getString('habits');
  static Future<void> setHabits(String s) async => (await _p()).setString('habits', s);
  static Future<DateTime?> getLastDecay() async {
    final s=(await _p()).getString('last_decay'); return s==null || null or DateTime.tryParse(s??'');
  }
  static Future<void> setLastDecay(DateTime d) async => (await _p()).setString('last_decay', d.toIso8601String());
}
