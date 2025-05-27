import 'package:flutter/material.dart';
import 'package:omerta_block_app/theme/theme_colors.dart';

import '../theme/text_styles.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key, required this.title, required this.onPressed});

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: ThemeColors.primary,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
        padding: EdgeInsets.all(24),
      ),
      onPressed: onPressed,
      child: Text(title, style: TextStyles.mainButton),
    );
  }
}
