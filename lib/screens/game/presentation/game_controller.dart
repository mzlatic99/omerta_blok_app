import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:omerta_block_app/screens/game/models/player.dart';

import '../../result/models/game_result.dart';

class GameController extends StateNotifier<List<Player>> {
  GameController() : super([]) {
    _loadPlayers();
  }

  final _playerBox = Hive.box<Player>('players');

  void _loadPlayers() {
    final stored = _playerBox.values.toList();
    state = stored;
  }

  void createPlayers(int count, List<String> names) {
    final newPlayers = List.generate(
      count,
      (i) => Player(id: i, name: names[i]),
    );

    state = newPlayers;
    _playerBox.clear();
    for (var player in newPlayers) {
      _playerBox.add(player);
    }
  }

  void addPoints(int playerId, int points) {
    final updated = [
      for (final player in state)
        if (player.id == playerId)
          Player(
            id: player.id,
            name: player.name,
            currentScore: player.currentScore + points,
            lastScore: points,
          )
        else
          player,
    ];
    state = updated;

    _playerBox.clear();
    for (var player in updated) {
      _playerBox.add(player);
    }
  }

  final _resultBox = Hive.box<GameResult>('results');

  void saveCurrentGame() {
    if (state.isNotEmpty) {
      _resultBox.add(GameResult(players: state, timestamp: DateTime.now()));
    }
  }

  void resetGame() {
    _playerBox.clear();
    state = [];
  }
}

final playerProvider = StateNotifierProvider<GameController, List<Player>>((
  ref,
) {
  return GameController();
});
