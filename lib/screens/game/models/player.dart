import 'package:hive/hive.dart';

part 'player.g.dart';

@HiveType(typeId: 0)
class Player extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int currentScore;

  @HiveField(3)
  final int lastScore;

  Player({
    required this.id,
    required this.name,
    this.currentScore = 0,
    this.lastScore = 0,
  });

  Player copyWith({int? id, String? name, int? currentScore, int? lastScore}) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      currentScore: currentScore ?? this.currentScore,
      lastScore: lastScore ?? this.lastScore,
    );
  }
}
