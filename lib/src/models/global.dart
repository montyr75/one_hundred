import 'dart:html';

import '../services/logger_service.dart';

const String appName = "dice";
final bool debugMode = window.location.host.contains('localhost');

LoggerService log;

LoggerService newLogger() => log = LoggerService(appName: appName, debugMode: debugMode);