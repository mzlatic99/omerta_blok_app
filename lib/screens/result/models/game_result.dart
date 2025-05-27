import 'package:hive/hive.dart';
import '../../game/models/player.dart';

part 'game_result.g.dart';

@HiveType(typeId: 1)
class GameResult extends HiveObject {
  @HiveField(0)
  final List<Player> players;

  @HiveField(1)
  final DateTime timestamp;

  GameResult({required this.players, required this.timestamp});
}
