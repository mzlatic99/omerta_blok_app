import 'package:flutter/material.dart';

import '../theme/theme.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({super.key, required this.controller, required this.hint});

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(color: ThemeColors.white),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeColors.primary, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeColors.white, width: 2),
        ),
        hintText: hint,
      ),
    );
  }
}
