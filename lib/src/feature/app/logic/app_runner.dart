import 'package:flutter/material.dart';
import 'package:rickandmorty/src/feature/app/widget/material_context.dart';

/// {@template app_runner}
/// [AppRunner] отвечает за инициализацию и запуск приложения.
/// {@endtemplate}
final class AppRunner {
  /// {@macro app_runner}
  const AppRunner._();

  static Future<void> initializeAndRun() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();

    // Удерживаем нативную заставку (splash screen).
    binding.deferFirstFrame();

    // TODO: Добавить инициализацию зависимостей.

    // Корневой виджет приложения.
    runApp(const MaterialContext());

    // Закрываем заставку (splash screen) и отображаем экран приложения.
    binding.allowFirstFrame();
  }
}
