import 'dart:async';

import 'package:angular/angular.dart';

import '../../services/logger_service.dart';

@Component(
  selector: 'dom-die',
  templateUrl: 'dom_die.html',
  styleUrls: ['dom_die_styles.css'],
  directives: [coreDirectives]
)
class DomDie {
  final LoggerService _log;

  Map<String, bool> dieClasses = {
    'die': true,
    'roll1': false,
    'roll2': false,
    'roll3': false,
    'roll4': false,
    'roll5': false,
    'roll6': false
  };

  final _onAnimationComplete = StreamController<int>();
  @Output() Stream<int> get onAnimationComplete => _onAnimationComplete.stream;

  DomDie(this._log) {
    _log.info("$runtimeType::DomDie()");
  }

  void roll(int num) {
    _clearRollClasses();

    // use timers to make sure data bindings propagate
    Timer(Duration(milliseconds: 10), () {
      dieClasses['roll$num'] = true;
      Timer(Duration(seconds: 2), () => _onAnimationComplete.add(num));
    });
  }

  void _clearRollClasses() {
    for (int i = 1; i <= 6; i++) {
      dieClasses['roll$i'] = false;
    }
  }
}
