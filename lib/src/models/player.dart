class Player {
  final String _name;
  int _totalScore = 0;
  int _turnScore = 0;
  final List<int> _turnRolls = [];

  Player(this._name);

  void rolled(int roll) {
    if (roll != 1) {
      _turnScore += roll;
      _turnRolls.add(roll);
    }
    else {
      _endTurn();
    }
  }

  void commit() {
    _totalScore += _turnScore;
    _endTurn();
  }

  void reset() {
    _totalScore = 0;
    _endTurn();
  }

  void _endTurn() {
    _turnScore = 0;
    _turnRolls.clear();
  }

  String get name => _name;
  int get totalScore => _totalScore;
  int get turnScore => _turnScore;
  List<int> get turnRolls => _turnRolls;
}