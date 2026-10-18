import 'package:flutter/widgets.dart';
import 'package:rickandmorty/src/feature/characters/data/characters_repository.dart';
import 'package:rickandmorty/src/feature/characters/logic/characters_state.dart';
import 'package:rickandmorty/src/feature/characters/model/character.dart';

/// {@template characters_controller}
/// Контроллер управления загрузкой персонажей.
/// {@endtemplate}
final class CharactersController {
  CharactersController({required this.repository})
    : state = ValueNotifier(CharactersState.idle);

  /// Репозиторий доступа к данным персонажей.
  final CharactersRepository repository;

  /// Состояние загрузки персонажей.
  final ValueNotifier<CharactersState> state;

  /// Список загруженных персонажей.
  final List<Character> _characters = [];

  /// Загрузка персонажей.
  Future<void> load() async {
    // Игнорируем новую загрузку при выполнении текущей.
    if (state.value.isLoading) return;

    // Отображаем экран загрузки.
    state.value = CharactersState.loading;

    try {
      // Загрузка данных персонажей.
      final response = await repository.getCharacters();
      _characters.addAll(response.results);

      // Отображаем загруженные [T].
      state.value = CharactersState.idle;
    } catch (_) {
      // Отображаем ошибку загрузки.
      state.value = CharactersState.error;

      rethrow;
    }
  }

  /// Освобождение занимаемых ресурсов.
  void dispose() {
    state.dispose();
  }
}
