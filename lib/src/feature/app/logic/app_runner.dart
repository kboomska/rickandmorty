import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmorty/src/feature/app/widget/app.dart';
import 'package:rickandmorty/src/feature/characters/data/characters_network_provider.dart';
import 'package:rickandmorty/src/feature/characters/data/characters_repository.dart';

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

    // Инициализация зависимостей.
    // В данном примере имеется только одна зависимость в виде репозитория
    // доступа к данным персонажей. Вместо условного Dependencies передаем
    // данный репозиторий напрямую.
    final charactersRepository = CharactersRepositoryImpl(
      dataProvider: CharactersNetworkProvider(
        client: http.Client(),
        baseUrl: const String.fromEnvironment('BASE_URL'),
      ),
    );

    runApp(App(repository: charactersRepository));

    // Закрываем заставку (splash screen) и отображаем экран приложения.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      binding.allowFirstFrame();
    });
  }
}
