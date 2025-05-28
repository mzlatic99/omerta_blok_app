import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/game/models/player.dart';
import '../screens/game/presentation/game_controller.dart';

final playerProvider = StateNotifierProvider<GameController, List<Player>>((
  ref,
) {
  return GameController();
});
