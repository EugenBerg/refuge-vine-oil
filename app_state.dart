
import 'package:flutter/material.dart';
import 'services/i18n.dart';
import 'services/storage.dart';
import 'services/logic.dart';

class AppState extends ChangeNotifier {
  String lang = 'de';
  I18n? dict;
  int oil = 50;
  int fruit = 0;

  Future<void> init() async {
    lang = await Store.getLang();
    dict = await I18n.load(lang);
    await Logic.applyDailyDecay();
    oil = await Store.getOil();
    fruit = await Logic.computeFruitScore();
    notifyListeners();
  }

  Future<void> setLang(String code) async {
    lang = code; await Store.setLang(code);
    dict = await I18n.load(code);
    notifyListeners();
  }

  Future<void> addHabit(String type) async {
    await Logic.addHabitAndOil(type);
    oil = await Store.getOil();
    fruit = await Logic.computeFruitScore();
    notifyListeners();
  }
}
