import 'dart:async';
import 'dart:math' as math;

import 'player.dart';

class Game {
  static math.Random _random = math.Random();
  static int rollDie() => _random.nextInt(6) + 1;

  final List<Player> _players = [];
  int _currentPlayerIndex;

  final StreamController<Player> _onTurn = new StreamController<Player>.broadcast();
  Stream<Player> get onTurn => _onTurn.stream;

  final StreamController<Player> _onWin = new StreamController<Player>.broadcast();
  Stream<Player> get onWin => _onWin.stream;

  void addPlayer(Player player) {
    _players.add(player);
  }

  void _nextPlayerTurn() {
    if (++_currentPlayerIndex >= _players.length) {
      _currentPlayerIndex = 0;
    }

    // announce the passing of the turn, in case the UI cares
    _onTurn.add(currentPlayer);
  }

  void newGame() {
    // reset all players to prepare for a new game
    for (Player player in players) {
      player.reset();
    }

    // if this index is set to -1, _nextPlayerTurn() will move it to 0
    _currentPlayerIndex = -1;

    _nextPlayerTurn();
  }

  int playerRoll([int roll]) {
    // if no roll is provided, generate one
    roll ??= rollDie();

    // tell the Player instance about the roll
    currentPlayer.rolled(roll);

    // a roll of 1 means the player's turn is over
    if (roll == 1) {
      _nextPlayerTurn();
    }

    return roll;
  }

  int playerCommitScore() {
    currentPlayer.commit();

    // if we have a win, announce it to the world
    if (currentPlayer.totalScore >= 100) {
      _onWin.add(currentPlayer);
    }
    else {
      _nextPlayerTurn();
    }

    return currentPlayer.totalScore;
  }

  List<Player> get players => _players;
  Player get currentPlayer => players[_currentPlayerIndex];
}