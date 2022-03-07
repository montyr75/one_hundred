import 'dart:async';

import '../models/models.dart';
import '../utils/roller.dart';

class GameCtrl {
  late Game game;

  final _onTurn = StreamController<Player>.broadcast();
  Stream<Player> get onTurn => _onTurn.stream;

  final _onWin = StreamController<Player>.broadcast();
  Stream<Player> get onWin => _onWin.stream;

  GameCtrl(List<String> playerNames) {
    game = Game(players: List.unmodifiable(playerNames.map((name) => Player(name: name)).toList()));
  }

  void nextTurn() {
    final roll = rollDie(6);

    if (roll != 1) {
      game = game.updateCurrentPlayer(game.currentPlayer.addRoll(roll));
      _onTurn.add(game.currentPlayer);
    }
    else {
      nextPlayer();
    }
  }

  void nextPlayer() {
    int nextIndex = game.currentPlayerIndex + 1;

    if (nextIndex >= game.players.length) {
      nextIndex = 0;
    }

    game =  game.copyWith(currentPlayerIndex: nextIndex);

    nextTurn();
  }

  void commit() {
    game = game.updateCurrentPlayer(game.currentPlayer.copyWith(
      score: game.currentPlayer.score + game.currentPlayer.rollTotal,
      rolls: const [],
    ));

    // TODO: Detect if there's a winner and send the winner out on onWin stream.
    // TODO: Only do next turn if there's not a winner.

    nextTurn();
  }
}