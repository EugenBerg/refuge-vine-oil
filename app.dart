
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'home.dart';

class RefugeApp extends StatelessWidget {
  const RefugeApp({super.key});
  @override
  Widget build(BuildContext context){
    final app = context.watch<AppState>();
    return MaterialApp(
      title: app.dict?.t('app_title') ?? 'Refuge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: const Color(0xFF0B4AA2), useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
