import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playremusica/core/settings/app_theme_data.dart';
import 'package:playremusica/presentation/widgets/gradient_screen.dart';

void main() {
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appThemeData,
      home: Scaffold(
        body: Center(
          child: GradientScreen(),
        ),
      ),
    );
  }
}
