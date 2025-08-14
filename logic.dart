
import 'dart:convert';
import 'dart:math';
import 'storage.dart';

class Logic {
  static const int decayPerDay = 2;
  static const Map<String,int> pts = {'word':3,'prayer':3,'love':5,'witness':5};

  static Future<void> applyDailyDecay() async {
    final last = await Store.getLastDecay();
    final now = DateTime.now();
    if (last==null){ await Store.setLastDecay(now); return; }
    final days = DateTime(now.year,now.month,now.day).difference(DateTime(last.year,last.month,last.day)).inDays;
    if (days<=0) return;
    final oil = (await Store.getOil()) - days*decayPerDay;
    await Store.setOil(oil);
    await Store.setLastDecay(now);
  }

  static Future<void> addHabitAndOil(String type) async {
    final p = await Store._p();
    final raw = await Store.getHabits();
    final list = raw==null?[]:json.decode(raw) as List<dynamic>;
    list.add({'date': DateTime.now().toIso8601String(), 'type': type});
    await Store.setHabits(json.encode(list));
    final oil = (await Store.getOil()) + (pts[type] ?? 0);
    await Store.setOil(oil);
  }

  static Future<int> computeFruitScore() async {
    final raw = await Store.getHabits();
    if (raw==null) return 0;
    final list = (json.decode(raw) as List<dynamic>).cast<Map<String,dynamic>>();
    final cutoff = DateTime.now().subtract(const Duration(days:7));
    int sum=0;
    for (final h in list){
      final dt = DateTime.tryParse(h['date'] as String) ?? DateTime.now();
      if (dt.isAfter(cutoff)) sum += (pts[h['type']] ?? 0);
    }
    return sum.clamp(0,100);
  }
}
