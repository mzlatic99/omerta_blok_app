import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omerta_block_app/theme/theme.dart';

import '../../../common/input_widget.dart';
import '../../../common/main_button_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Image.asset(Assets.cards.hero0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Omerta",
                    style: TextStyles.titleText,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: MainButton(
                title: "Kreiraj blok",
                onPressed: () => _inputDialog(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MainButton(
                title: "Vidi rezultate",
                onPressed: () => context.go("/scores"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _inputDialog(BuildContext context) {
  final TextEditingController controller = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
      backgroundColor: ThemeColors.main,
      elevation: 10,
      shadowColor: ThemeColors.primary,
      title: Text('Unesi broj igrača', style: TextStyles.mainButton),
      content: InputWidget(
        controller: controller,
        hint: "3-7",
        keyboardType: TextInputType.number,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Odustani', style: TextStyles.declineButton),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: ThemeColors.main),
          onPressed: () {
            final enteredText = controller.text;
            final value = int.tryParse(enteredText);

            if (value != null && value > 2 && value < 8) {
              context.go('/game', extra: value);
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Nemre tak')));
            }
          },
          child: Text('Potvrdi', style: TextStyles.confirmButton),
        ),
      ],
    ),
  );
}
