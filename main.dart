
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(create: (_)=>AppState()..init(), child: const RefugeApp()));
}
