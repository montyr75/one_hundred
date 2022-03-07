import '../utils/utils.dart';
import 'player.dart';

class Game {
  static const minPlayers = 2;
  static const maxPlayers = 6;

  final List<Player> players;
  final int currentPlayerIndex;

  Player get currentPlayer => players[currentPlayerIndex];

  Game({this.players = const [], this.currentPlayerIndex = 0});

  Game copyWith({
    List<Player>? players,
    int? currentPlayerIndex,
  }) {
    return Game(
      players: players ?? this.players,
      currentPlayerIndex: currentPlayerIndex ?? this.currentPlayerIndex,
    );
  }

  Game updateCurrentPlayer(Player player) =>
      copyWith(players: List.unmodifiable(players..replaceWith(currentPlayer, player)));
}