import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'src/models/global.dart';
import 'src/services/logger_service.dart';
import 'src/models/game.dart';
import 'src/models/player.dart';
import 'src/components/game_view/game_view.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  styleUrls: ['package:angular_components/app_layout/layout.scss.css'],
  directives: [coreDirectives, materialDirectives, GameView],
  providers: [FactoryProvider(LoggerService, newLogger), materialProviders]
)
class AppComponent {
  final LoggerService _log;

  Game game;

  AppComponent(this._log) {
    _log.info("$runtimeType::AppComponent()");

    game = Game()
      ..addPlayer(Player("Player 1"))
      ..addPlayer(Player("Player 2"))
      ..newGame();
  }
}
