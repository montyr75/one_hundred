import 'dart:math';

import 'utils.dart';

final _rng = Random(DateTime.now().millisecondsSinceEpoch);

int rollDie(int sides) => _rng.nextInt(sides) + 1;

int rollDiceMod(int qty, int sides, [int mod = 0]) => List.generate(qty, (_) => rollDie(sides)).sum() + mod;

bool rollPercent(int percentChance) => rollDie(100) <= percentChance;

class DiceExpression {
  final int qty;
  final int sides;
  final int mod;

  const DiceExpression(this.qty, this.sides, [this.mod = 0]) : assert(qty > 0 && sides > 0);

  /// This version parses the formula using substrings and explicit steps
  factory DiceExpression.parse1(String formula) {
    // sanitize the formula (eliminate spaces and case sensitivity)
    formula = formula.replaceAll(' ', '').toLowerCase();

    // locate the D
    final indexOfD = formula.indexOf('d');

    // extract qty
    final qtyStr = formula.substring(0, indexOfD);

    // extract sides
    final sidesStr = formula.substring(indexOfD + 1);

    try {
      // convert qty to an int
      final qty = int.parse(qtyStr);

      // convert sides to an int
      final sides = int.parse(sidesStr);

      // create DiceExpression
      final exp = DiceExpression(qty, sides);

      return exp;
    }
    catch (e) {
      rethrow;
    }
  }

  factory DiceExpression.parse2(String formula) {
    // sanitize the formula (eliminate spaces and case sensitivity)
    formula = formula.replaceAll(' ', '').toLowerCase();

    // locate the D
    final indexOfD = formula.indexOf('d');

    try {
      return DiceExpression(
        int.parse(formula.substring(0, indexOfD)),
        int.parse(formula.substring(indexOfD + 1)),
      );
    }
    catch (e) {
      rethrow;
    }
  }

  factory DiceExpression.parse3(String formula) {
    // sanitize the formula (eliminate spaces and case sensitivity)
    formula = formula.replaceAll(' ', '').toLowerCase();

    // split the formula into its parts
    final List<String> parts = formula.split('d');

    try {
      return DiceExpression(
        int.parse(parts.first),
        int.parse(parts.last),
      );
    }
    catch (e) {
      rethrow;
    }
  }

  factory DiceExpression.parse(String formula) {
    // sanitize the formula (eliminate spaces and case sensitivity)
    formula = formula.replaceAll(' ', '').toLowerCase();

    // split the formula into its parts
    final parts = formula.split('d');

    // extract qty
    final qtyStr = parts.first;

    // extract sides and (maybe) mod
    final sidesModStr = parts.last;

    // create holder variables
    String sidesStr;
    String? modStr;

    // split the sides/mod area, if necessary
    if (sidesModStr.contains('+')) {
      final sidesModParts = sidesModStr.split('+');
      sidesStr = sidesModParts.first;
      modStr = sidesModParts.last;
    }
    else if (sidesModStr.contains('-')) {
      final sidesModParts = sidesModStr.split('-');
      sidesStr = sidesModParts.first;
      modStr = "-${sidesModParts.last}";
    }
    else {
      sidesStr = sidesModStr;
    }

    try {
      return DiceExpression(
        int.parse(qtyStr),
        int.parse(sidesStr),
        modStr != null ? int.parse(modStr) : 0,
      );
    }
    catch (e) {
      rethrow;
    }
  }

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