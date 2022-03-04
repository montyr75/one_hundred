import 'dart:math';

import 'utils.dart';

// TODO: Add formula parsing to DiceExpression.

final _rng = Random(DateTime.now().millisecondsSinceEpoch);

int rollDie(int sides) => _rng.nextInt(sides) + 1;

int rollDiceMod(int qty, int sides, [int mod = 0]) => List.generate(qty, (_) => rollDie(sides)).sum() + mod;

bool rollPercent(int percentChance) => rollDie(100) <= percentChance;

class DiceExpression {
  final int qty;
  final int sides;
  final int mod;

  const DiceExpression(this.qty, this.sides, [this.mod = 0]) : assert(qty > 0 && sides > 0);

  int rollDice() => rollDiceMod(qty, sides, mod);

  RollResult roll() {
    final rolls = List.generate(qty, (_) => rollDie(sides));
    final rollsTotal = rolls.sum();
    final total = rollsTotal + mod;

    return RollResult(
      this,
      rolls,
      rollsTotal,
      total,
    );
  }

  @override
  String toString() =>"${qty}d$sides$modString";

  String get modString {
    if (mod == 0) {
      return '';
    }
    else if (mod > 0) {
      return ' + $mod';
    }
    else {
      return ' - ${mod.abs()}';
    }
  }
}

class RollResult {
  final DiceExpression exp;
  final List<int> rolls;
  final int rollsTotal;
  final int total;

  RollResult(this.exp, this.rolls, this.rollsTotal, this.total);

  @override
  String toString() => "$exp = $rolls${exp.modString} = $total";
}