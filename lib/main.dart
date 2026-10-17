import 'dart:async';
import 'dart:developer';

import 'package:rickandmorty/src/feature/app/logic/app_runner.dart';

void main() {
  runZonedGuarded(() => AppRunner.initializeAndRun(), (error, stackTrace) {
    log('Zone error: $error', error: error, stackTrace: stackTrace);
  });
}
