import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class BlaIconButton extends StatelessWidget {
  const BlaIconButton({super.key, this.icon, this.onPressed});

  final IconData? icon;
  final VoidCallback? onPressed;

   @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      color: BlaColors.primary,
    );
  }
}