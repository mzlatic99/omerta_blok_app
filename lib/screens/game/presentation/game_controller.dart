import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:omerta_block_app/screens/game/models/player.dart';

import '../../result/models/game_result.dart';

class GameController extends StateNotifier<List<Player>> {
  GameController() : super([]) {
    _loadPlayers();
  }

  final _playerBox = Hive.box<Player>('players');
  final _resultBox = Hive.box<GameResult>('results');

  final Set<int> _updatedThisRound = {};
  Set<int> get playersUpdatedThisRound => _updatedThisRound;

  int _currentRound = 1;

  int get currentRound => _currentRound;

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

    _updatedThisRound.clear();
    _currentRound = 1;
  }

  void addPoints(int playerId, int points) {
    if (points < 0) return;

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

    _updatedThisRound.add(playerId);

    if (_updatedThisRound.length == state.length) {
      _currentRound++;
      _updatedThisRound.clear();
    }

    _playerBox.clear();
    for (var player in updated) {
      _playerBox.add(player);
    }
  }

  void saveCurrentGame() {
    if (state.isNotEmpty) {
      _resultBox.add(GameResult(players: state, timestamp: DateTime.now()));
    }
  }

  void resetGame() {
    _playerBox.clear();
    _updatedThisRound.clear();
    _currentRound = 1;
    state = [];
  }

  void editLastPoints(int playerId, int newPoints) {
    if (newPoints < 0) return;

    final updated = [
      for (final player in state)
        if (player.id == playerId)
          Player(
            id: player.id,
            name: player.name,
            currentScore: player.currentScore - player.lastScore + newPoints,
            lastScore: newPoints,
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
}
