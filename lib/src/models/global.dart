import 'dart:html';

import '../services/logger_service.dart';

const String _appName = "dice";
final bool _debugMode = window.location.host.contains('localhost');

LoggerService newLogger() =>  LoggerService(appName: _appName, debugMode: _debugMode);