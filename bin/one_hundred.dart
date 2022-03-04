import 'package:console/console.dart';
import 'package:one_hundred/utils/roller.dart';

void main() {
  Console.init();

  int count = 0;

  for (int i = 0; i < 100; i++) {
    if (rollPercent(40)) {
      count++;
    }
  }

  print(count);
}
