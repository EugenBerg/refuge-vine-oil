
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/i18n.dart';
import '../services/logic.dart';
import '../services/storage.dart';
import '../ui/vine.dart';
import '../ui/oil_meter.dart';
import 'app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    final app = context.watch<AppState>();
    final I18n? i18n = app.dict;
    if (i18n == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.t('home_title')),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: (c)=>context.read<AppState>().setLang(c),
            itemBuilder: (_)=>const [
              PopupMenuItem(value:'de', child: Text('Deutsch')),
              PopupMenuItem(value:'en', child: Text('English')),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(i18n.t('home_lead')),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    VineView(oil: app.oil.toDouble(), fruit: app.fruit),
                    const SizedBox(height: 8),
                    Text(i18n.t('vine_hint')),
                    const SizedBox(height: 8),
                    OilMeter(oil: app.oil),
                    const SizedBox(height: 8),
                    Wrap(spacing: 8, runSpacing: 8, children: [
                      ElevatedButton.icon(onPressed: ()=>context.read<AppState>().addHabit('word'), icon: const Icon(Icons.menu_book), label: const Text('Wort/Word')),
                      ElevatedButton.icon(onPressed: ()=>context.read<AppState>().addHabit('prayer'), icon: const Icon(Icons.favorite), label: const Text('Gebet/Prayer')),
                      ElevatedButton.icon(onPressed: ()=>context.read<AppState>().addHabit('love'), icon: const Icon(Icons.volunteer_activism), label: const Text('Liebe/Love')),
                      ElevatedButton.icon(onPressed: ()=>context.read<AppState>().addHabit('witness'), icon: const Icon(Icons.campaign), label: const Text('Zeugnis/Witness')),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
