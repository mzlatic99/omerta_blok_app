import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:omerta_block_app/common/input_widget.dart';
import 'package:omerta_block_app/common/main_button_widget.dart';
import 'package:omerta_block_app/screens/game/presentation/game_controller.dart';
import 'package:omerta_block_app/utility/sort_extension.dart';
import '../../../theme/theme.dart';
import '../models/player.dart';

class GamePage extends ConsumerStatefulWidget {
  final int playerCount;

  const GamePage({super.key, required this.playerCount});

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  final List<TextEditingController> _nameControllers = [];

  bool _namesEntered = false;

  @override
  void initState() {
    super.initState();
    _nameControllers.addAll(
      List.generate(widget.playerCount, (index) => TextEditingController()),
    );
  }

  void _confirmNames() {
    final names = _nameControllers.map((c) => c.text.trim()).toList();
    if (names.any((name) => name.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sva imena moraju biti unesena.')),
      );
      return;
    }
    ref.read(playerProvider.notifier).createPlayers(widget.playerCount, names);
    setState(() => _namesEntered = true);
  }

  void _addPointsDialog(Player player) {
    final controller = TextEditingController();
    final focusNode = FocusNode();

    showDialog(
      context: context,
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          focusNode.requestFocus();
        });
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 95, 65, 54),
          elevation: 10,
          shadowColor: Colors.brown,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20),
          ),
          title: Text(
            'Dodaj bodove za ${player.name}',
            style: TextStyles.mainButton,
          ),
          content: InputWidget(
            controller: controller,
            hint: "npr. 10",
            keyboardType: TextInputType.number,
            focusNode: focusNode,
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(15),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Odustani', style: TextStyles.declineButton),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColors.main,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(15),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24),
              ),
              onPressed: () {
                final value = int.tryParse(controller.text.trim());
                if (value != null && value > 0) {
                  ref.read(playerProvider.notifier).addPoints(player.id, value);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Dodaj', style: TextStyles.confirmButton),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final players = ref.watch(playerProvider);
    final sortedPlayers = players.sorted(
      (a, b) => a.currentScore.compareTo(b.currentScore),
    );
    final leadingPlayerId = sortedPlayers.isNotEmpty
        ? sortedPlayers.first.id
        : -1;

    return Scaffold(
      appBar: AppBar(
        title: !_namesEntered ? Text('Unos Igrača') : Text('Tablica'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: !_namesEntered
            ? ListView(
                children: [
                  ...List.generate(widget.playerCount, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: InputWidget(
                        controller: _nameControllers[index],
                        hint: "Ime ${index + 1}. igrača",
                        keyboardType: TextInputType.name,
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  MainButton(title: "Potvrdi imena", onPressed: _confirmNames),
                ],
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        ...sortedPlayers.map((player) {
                          final isLeader = player.id == leadingPlayerId;
                          return Card(
                            margin: EdgeInsets.only(bottom: 16),
                            elevation: isLeader ? 8 : 0,
                            shadowColor: isLeader
                                ? Colors.orange[200]
                                : Colors.transparent,
                            key: ValueKey(player.id),
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            color: isLeader ? Colors.orange[100] : Colors.brown,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: ThemeColors.primary,
                                child: Text(
                                  '${player.currentScore}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ThemeColors.white,
                                  ),
                                ),
                              ),
                              title: Row(
                                children: [
                                  Text(player.name, style: TextStyles.names),
                                  if (isLeader)
                                    const Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Icon(
                                        Icons.emoji_events,
                                        color: Color.fromARGB(
                                          213,
                                          255,
                                          109,
                                          64,
                                        ),
                                        size: 24,
                                      ),
                                    ),
                                ],
                              ),
                              subtitle: Text(
                                'Zadnje dodano: +${player.lastScore}',
                                style: TextStyles.addedText,
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => _addPointsDialog(player),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ref.read(playerProvider.notifier).resetGame();
                              context.go('/');
                            },
                            icon: const Icon(
                              Icons.restart_alt,
                              color: Color.fromARGB(255, 255, 17, 0),
                            ),
                            label: Text(
                              "Resetiraj",
                              style: TextStyles.declineButton,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(
                                255,
                                190,
                                86,
                                0,
                              ),
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 24,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: SafeArea(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                ref
                                    .read(playerProvider.notifier)
                                    .saveCurrentGame();
                                ref.read(playerProvider.notifier).resetGame();
                                context.go('/scores');
                              },
                              icon: const Icon(
                                Icons.save,
                                color: Colors.lightGreenAccent,
                              ),
                              label: Text(
                                "Spremi rezultat",
                                style: TextStyles.declineButton,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[800],
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    8,
                                  ),
                                ),
                                padding: EdgeInsets.all(24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
