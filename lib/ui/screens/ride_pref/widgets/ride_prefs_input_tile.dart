import 'package:flutter/material.dart';
import '../../../widgets/actions/bla_icon_button.dart';
import '../../../theme/theme.dart';

class RidePrefsInputTile extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData leftIcon;

  final bool isPlaceholder; // to switch text color if it's a placeholder its lighter text
  //optional right icon & press button
  final IconData? rightIcon; 
  final VoidCallback? onRightIconPressed;

  const RidePrefsInputTile({
    super.key,
    required this.title,
    required this.onPressed,
    required this.leftIcon,
    this.rightIcon,
    this.onRightIconPressed, 
    this.isPlaceholder = false,
  });

  Color get textColor => isPlaceholder ? BlaColors.textLight : BlaColors.textNormal;

  @override 
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(
        title,
        style: BlaTextStyles.button.copyWith(color: textColor),
      ),
      leading: Icon(leftIcon, size: BlaSize.icon, color: BlaColors.iconLight),
      trailing: rightIcon != null && onRightIconPressed != null
          ? BlaIconButton(icon: rightIcon, onPressed: onRightIconPressed)
          : null,
    );
  }
}
