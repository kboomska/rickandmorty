import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:rickandmorty/src/feature/characters/data/characters_repository.dart';
import 'package:rickandmorty/src/feature/characters/logic/characters_state.dart';
import 'package:rickandmorty/src/feature/characters/model/character.dart';

/// {@template characters_controller}
/// Контроллер управления загрузкой персонажей.
/// {@endtemplate}
final class CharactersController {
  CharactersController({
    required this.repository,
    required this.scrollController,
  }) : state = ValueNotifier(CharactersState.idle);

  /// Репозиторий доступа к данным персонажей.
  final CharactersRepository repository;

  /// Контроллер прокрутки экрана персонажей.
  final ScrollController scrollController;

  /// Состояние загрузки персонажей.
  final ValueNotifier<CharactersState> state;

  /// Список загруженных персонажей.
  final List<Character> _characters = [];

  /// Текущая страница.
  int _currentPage = 1;

  /// Общее количество страниц.
  int _totalPages = 1;

  /// Наличие незагруженных страниц.
  bool get hasMorePages => _currentPage < _totalPages;

  /// Список загруженных персонажей.
  ///
  /// Внесение изменений в [characters] не влияет на исходный список.
  List<Character> get characters => _characters.toList();

  /// Наличие загруженных персонажей.
  bool get hasCharacters => _characters.isNotEmpty;

  /// Загрузка персонажей.
  Future<void> load(int page) async {
    // Игнорируем новую загрузку при выполнении текущей.
    if (state.value.isLoading) return;

    // Отображаем экран загрузки.
    state.value = CharactersState.loading;

    try {
      // Загрузка данных персонажей.
      final response = await repository.getCharacters(
        page.clamp(1, _totalPages),
      );
      _characters.addAll(response.results);
      _totalPages = response.info.pages;
      _currentPage = page;

      // Отображаем загруженные [T].
      state.value = CharactersState.idle;
    } catch (_) {
      // Отображаем ошибку загрузки.
      state.value = CharactersState.error;

      rethrow;
    }
  }

  /// Повторная загрузка экрана персонажей.
  Future<void> reload() => load(1);

  /// Загрузка следующей страницы персонажей.
  Future<void> next() => load(math.min(_currentPage + 1, _totalPages));

  /// Отслеживание изменения прокрутки списка персонажей.
  Future<void> onScrollChanged() async {
    if (state.value.isLoading || !hasMorePages) return;

    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      await next();
    }
  }

  /// Освобождение занимаемых ресурсов.
  void dispose() {
    state.dispose();
  }
}
