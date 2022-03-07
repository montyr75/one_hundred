import 'package:console/console.dart';
import 'package:one_hundred/controllers/game_ctrl.dart';
import 'package:one_hundred/models/models.dart';
import 'package:one_hundred/utils/console_utils.dart';

late GameCtrl ctrl;

void main() {
  Console.init();

  printTitle();
}

void printTitle() {
  printMessage("********  One Hundred  ********\n");
}

void newGame([List<String>? playerNames]) {
  ctrl = GameCtrl(playerNames ?? getPlayerNames());

  ctrl.onTurn.listen(doPlayerTurn);
  ctrl.onWin.listen(doPlayerWins);
}

List<String> getPlayerNames() {
  final numberOfPlayers = promptForIntExt(
    "Number of players (2-6): ",
    validator: (value) => value >= Game.minPlayers && value <= Game.maxPlayers,
  );

  return List.generate(numberOfPlayers, (_) => promptForStringExt("Player Name: "));
}

void doPlayerTurn(Player player) {
  printMessage(player.toString());
  printMessage("${player.rolls} = ${player.rollTotal}");

  printConsoleMenu([
    ConsoleMenuOption("Roll Again", onSelect: ctrl.nextTurn),
    ConsoleMenuOption("Commit Score and End Turn", onSelect: ctrl.commit),
  ]);

}

void doPlayerWins(Player player) {

}