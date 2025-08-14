
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class I18n {
  final Map<String, dynamic> _d;
  I18n._(this._d);
  static Future<I18n> load(String code) async {
    final raw = await rootBundle.loadString('assets/i18n/$code.json').catchError((_) async {
      return await rootBundle.loadString('assets/i18n/en.json');
    });
    return I18n._(json.decode(raw) as Map<String, dynamic>);
  }
  String t(String k)=> (_d[k] ?? '') as String;
  List<String> get verses => (_d['verses'] as List<dynamic>).cast<String>();
}
