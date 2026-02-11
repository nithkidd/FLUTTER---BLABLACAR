import 'package:blabla/ui/screens/ride_pref/ride_prefs_screen.dart';
import 'package:flutter/material.dart';
import 'ui/screens/test/ride_prefs_form_test_screen.dart';
import 'ui/theme/theme.dart';

void main() {
  runApp(const BlaBlaApp());
}

class BlaBlaApp extends StatelessWidget {
  const BlaBlaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: blaTheme,
      home: const RidePrefsScreen(),
    );
  }
}
