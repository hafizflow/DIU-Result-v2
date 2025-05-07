import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_practice/app.dart';
import 'package:riverpod_practice/themes/theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DIU Result',
      home: const AppScreen(),
      theme: DIUResultAppTheme.theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
