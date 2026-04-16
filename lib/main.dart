import 'package:flutter/material.dart';
import 'package:unitask/app/router/app_router.dart';
import 'package:unitask/app/theme/app_theme.dart';

void main() {
  runApp(const UniTaskApp());
}

class UniTaskApp extends StatelessWidget {
  const UniTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: .system,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }
}
