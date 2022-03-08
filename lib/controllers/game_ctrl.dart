import 'dart:async';

import '../models/models.dart';
import '../utils/roller.dart';

class GameCtrl {
  late Game game;

  final _onTurn = StreamController<Player>.broadcast();
  Stream<Player> get onTurn => _onTurn.stream;

  final _onOne = StreamController<Player>.broadcast();
  Stream<Player> get onOne => _onOne.stream;

  final _onWin = StreamController<Player>.broadcast();
  Stream<Player> get onWin => _onWin.stream;

  GameCtrl(List<String> playerNames) {
    game = Game(players: List.unmodifiable(playerNames.map((name) => Player(name: name)).toList()));

    // delay stream output until listeners are in place
    scheduleMicrotask(nextTurn);
  }

  void nextTurn() {
    final roll = rollDie(6);

    if (roll != 1) {
      game = game.updateCurrentPlayer(game.currentPlayer.addRoll(roll));
      _onTurn.add(game.currentPlayer);
    }
    else {
      _onOne.add(game.currentPlayer);
      game = game.updateCurrentPlayer(game.currentPlayer.copyWith(rolls: const []));

      // delay to allow all streams to complete
      scheduleMicrotask(nextPlayer);
    }
  }

  void nextPlayer() {
    int nextIndex = game.currentPlayerIndex + 1;

    if (nextIndex >= game.players.length) {
      nextIndex = 0;
    }

    game = game.copyWith(currentPlayerIndex: nextIndex);

    nextTurn();
  }

  void commit() {
    game = game.updateCurrentPlayer(game.currentPlayer.copyWith(
      score: game.currentPlayer.commitTotal,
      rolls: const [],
    ));

    if (game.currentPlayer.score >= 100) {
      _onWin.add(game.currentPlayer);
    }
    else {
      nextPlayer();
    }
  }
}