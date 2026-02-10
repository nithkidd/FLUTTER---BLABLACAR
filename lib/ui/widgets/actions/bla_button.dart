import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class BlaButton extends StatelessWidget {
  const BlaButton({super.key, required this.color, required this.text, required this.onTap, this.icon});
  final Color color;
  final String text;
  final IconData? icon; //optional icon
  final VoidCallback onTap;

  
  Color get _backgroundColor => color == BlaColors.primary ? BlaColors.primary : BlaColors.white;
  Color get _textColor => color == BlaColors.primary ? BlaColors.white : BlaColors.primary;
  Color get _iconColor => color == BlaColors.primary ? BlaColors.white : BlaColors.primary;
  
  // border color to be the same as the background color for primary, and grey for secondary
  //reason for putting same color border for primary too is to avoid inconsistent button size
  Color get _buttonBorderColor => _backgroundColor == BlaColors.primary ? BlaColors.primary : BlaColors.disabled;
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: _backgroundColor,
        shape: StadiumBorder(
          side: BorderSide(color: _buttonBorderColor),
        ),
        padding: const EdgeInsets.all(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //if icon is not null, show it with some spacing, else show only the text
          if (icon != null) ...[
            Icon(icon, size: 20, color: _iconColor),
            const SizedBox(width: 8),
          ],
          Text(text, style: BlaTextStyles.button.copyWith(color: _textColor)),
        ],
      ),
    );
  }
}


