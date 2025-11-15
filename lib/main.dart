import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playremusica/core/settings/app_theme_data.dart';
import 'package:playremusica/core/utils/router_observer.dart';
import 'package:playremusica/features/splash/presentation/pages/splash_page.dart';

void main() {
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      theme: appThemeData,
      home: SplashPage()
    );
  }
}
