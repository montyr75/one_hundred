import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../../services/logger_service.dart';
import '../../models/game.dart';
import '../../models/player.dart';
import '../dom_die/dom_die.dart';

@Component(
  selector: 'game-view',
  templateUrl: 'game_view.html',
  directives: [coreDirectives, materialDirectives, DomDie]
)
class GameView implements AfterViewInit {
  final LoggerService _log;

  Game _game;

  @ViewChild('die') DomDie dieEl;
  bool rollEnabled = true;
  String winner;

  GameView(this._log) {
    _log.info("$runtimeType::GameView()");
  }

  @override void ngAfterViewInit() {
    dieEl.onAnimationComplete.listen(_dieAnimationComplete);
  }

  void newGame() {
    winner = null;
    game.newGame();
  }

  void roll() {
    _rollDomDie(Game.rollDie());
    rollEnabled = false;
  }

  void _rollDomDie(int num) {
    dieEl.roll(num);
  }

  void _dieAnimationComplete(int dieRoll) {
    game.playerRoll(dieRoll);
    rollEnabled = true;
  }

  void _win(Player player) {
    winner = player.name;
  }

  Game get game => _game;
  @Input() void set game(Game value) {
    _game = value;
    game.onWin.listen(_win);
  }

  List<int> get turnRolls => game.currentPlayer.turnRolls;
}
