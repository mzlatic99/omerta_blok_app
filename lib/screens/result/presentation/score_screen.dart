import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import '../../../theme/text_styles.dart';
import '../models/game_result.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  late Box<GameResult> _box;

  @override
  void initState() {
    super.initState();
    _box = Hive.box<GameResult>('results');
  }

  @override
  Widget build(BuildContext context) {
    final entries = _box.toMap().entries.toList().reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Povijest igara"),
        actions: [
          IconButton(
            onPressed: () => context.go("/"),
            icon: const Icon(Icons.cancel_outlined),
          ),
        ],
      ),
      body: entries.isEmpty
          ? const Center(child: Text("Nema spremljenih rezultata."))
          : ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                final key = entry.key;
                final game = entry.value;

                return Card(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  child: ListTile(
                    title: Text(
                      "Igra od ${game.timestamp.toLocal().day}.${game.timestamp.toLocal().month}.${game.timestamp.toLocal().year} "
                      "${game.timestamp.toLocal().hour}:${game.timestamp.toLocal().minute.toString().padLeft(2, '0')}",
                      style: TextStyles.historyTitle,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: game.players
                          .map(
                            (p) => Text(
                              "${p.name}: ${p.currentScore}",
                              style: TextStyles.confirmButton,
                            ),
                          )
                          .toList(),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () async {
                        await _box.delete(key);
                        setState(() {}); // Refresh the UI after deletion
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
