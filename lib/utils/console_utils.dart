import 'package:console/console.dart' show Console, Prompter;

typedef PromptValidator = bool Function(String input);

const invalidInput = "Invalid input.";

enum ConsoleColor {
  black,
  red,
  green,
  yellow,
  blue,
  magenta,
  cyan,
  white,
}

void highlight(String value, [int colorId = 3]) {
  Console.setTextColor(colorId);
  Console.write(value);
  Console.setTextColor(7);
}

int? promptForInt(String prompt) {
  Console.setTextColor(ConsoleColor.green.index);
  final input = Prompter("\n$prompt").promptSync();
  return int.tryParse(input ?? '');
}

double? promptForDouble(String prompt) {
  Console.setTextColor(ConsoleColor.green.index);
  final input = Prompter("\n$prompt").promptSync();
  return double.tryParse(input ?? '');
}

double promptForDoubleExt(String prompt, {String errorMsg = invalidInput}) {
  final input = promptForDouble(prompt);

  if (input != null) {
    return input;
  }

  printError(errorMsg);
  return promptForDoubleExt(prompt);
}

int promptForIntExt(String prompt, {String errorMsg = invalidInput}) {
  final input = promptForInt(prompt);

  if (input != null) {
    return input;
  }

  printError(errorMsg);
  return promptForIntExt(prompt);
}

String? promptForString(String prompt) {
  Console.setTextColor(ConsoleColor.green.index);
  return Prompter("\n$prompt").promptSync();
}

String promptForStringExt(String prompt, {PromptValidator? validator, String errorMsg = invalidInput}) {
  final input = promptForString(prompt);

  // validate input
  if (input == null || input.isEmpty || (validator != null && !validator(input))) {
    printError(errorMsg);
    return promptForStringExt(prompt, validator: validator, errorMsg: errorMsg);
  }

  return input;
}

void printMenuItem({
  required String phrase,
  int highlightIndex = 0,
  ConsoleColor highlightColor = ConsoleColor.yellow,
  ConsoleColor defaultColor = ConsoleColor.white
}) {
  assert(phrase.isNotEmpty && highlightIndex < phrase.length && highlightIndex >= 0);

  // pre-highlight text
  if (highlightIndex > 0) {
    Console.setTextColor(defaultColor.index);
    Console.write(phrase.substring(0, highlightIndex));
  }

  // highlight letter
  Console.setTextColor(highlightColor.index);
  Console.write(phrase[highlightIndex]);

  // post-highlight text
  if (highlightIndex < phrase.length - 1) {
    Console.setTextColor(defaultColor.index);
    Console.write(phrase.substring(highlightIndex + 1));
  }

  consoleNewLine();
}

void consoleNewLine() => Console.write("\n");

void printError(String msg) {
  Console.setTextColor(ConsoleColor.red.index);
  Console.write("\n$msg\n");
}

void printSuccess(String msg) {
  Console.setTextColor(ConsoleColor.yellow.index);
  Console.write("\n$msg\n");
}

void printMessage(String msg) {
  Console.setTextColor(ConsoleColor.white.index, bright: true);
  Console.write("\n$msg\n");
}

void printInlineMessage(String msg) {
  Console.setTextColor(ConsoleColor.white.index, bright: true);
  Console.write(msg);
}