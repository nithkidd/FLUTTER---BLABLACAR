import 'package:flutter/material.dart';
import '../ride_pref/widgets/ride_prefs_form.dart';

/// Test screen to display and test the RidePrefForm widget
class RidePrefFormTestScreen extends StatelessWidget {
  const RidePrefFormTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ride Preference Form Test')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: RidePrefForm(),
      ),
    );
  }
}
