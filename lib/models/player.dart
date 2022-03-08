import '../utils/utils.dart';

class Player {
  final String name;
  final int score;
  final List<int> rolls;

  Player({
    this.name = "<unnamed>",
    this.score = 0,
    this.rolls = const [],
  });

  Player copyWith({
    String? name,
    int? score,
    List<int>? rolls,
  }) {
    return Player(
      name: name ?? this.name,
      score: score ?? this.score,
      rolls: rolls ?? this.rolls,
    );
  }
  
  Player setName(String value) => copyWith(name: value); 
  Player addRoll(int value) => copyWith(rolls: List.unmodifiable(rolls.toList()..add(value)));

  int get rollTotal => rolls.sum();
  int get commitTotal => rollTotal + score;

  @override
  String toString() => "$name: $score";
}