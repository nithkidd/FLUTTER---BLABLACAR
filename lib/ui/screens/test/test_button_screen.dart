import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../widgets/actions/bla_button.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: blaTheme,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Primary button
              BlaButton(
                color: BlaColors.primary,
                text: "test primary",
                onTap: () {},
              ),
              const SizedBox(height: 16),

              // Secondary button
              BlaButton(
                color: BlaColors.white,
                text: "test secondary",
                onTap: () {},
              ),
              const SizedBox(height: 16),

              // Primary with icon
              BlaButton(
                color: BlaColors.primary,
                icon: Icons.access_alarm,
                text: "test primary with icon",
                onTap: () {},
              ),
              const SizedBox(height: 16),

              // Secondary with icon
              BlaButton(
                color: BlaColors.white,
                icon: Icons.access_alarm,
                text: "test secondary with icon",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
