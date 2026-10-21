import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:rickandmorty/src/common/utils/error/network_exception.dart';
import 'package:rickandmorty/src/feature/characters/data/characters_repository.dart';
import 'package:rickandmorty/src/feature/characters/logic/characters_state.dart';
import 'package:rickandmorty/src/feature/characters/model/character.dart';

/// {@template characters_controller}
/// Контроллер управления загрузкой персонажей.
/// {@endtemplate}
final class CharactersController {
  /// {@macro characters_controller}
  CharactersController({required this.repository})
    : state = ValueNotifier(CharactersState.idle);

  /// Репозиторий доступа к данным персонажей.
  final CharactersRepository repository;

  /// Состояние загрузки персонажей.
  final ValueNotifier<CharactersState> state;

  /// Список загруженных персонажей.
  final List<Character> _characters = [];

  /// Последний запрос поиска персонажа по имени.
  String _lastSearch = '';

  /// Сообщение об ошибке загрузки персонажей.
  String? _errorMessage;

  /// Текущая страница.
  int _currentPage = 0;

  /// Общее количество страниц.
  int _totalPages = 1;

  /// Начальная позиция прокрутки списка персонажей.
  double _position = 0.0;

  /// Сообщение об ошибке загрузки персонажей.
  String get errorMessage => _errorMessage ?? 'Something went wrong';

  /// Наличие незагруженных страниц.
  bool get hasMorePages => _currentPage < _totalPages;

  /// Начальная позиция прокрутки списка персонажей.
  double get scrollPosition => _position;

  /// Наличие загруженных персонажей.
  bool get hasCharacters => _characters.isNotEmpty;

  /// Список загруженных персонажей.
  ///
  /// Внесение изменений в [characters] не влияет на исходный список.
  List<Character> get characters => _characters.toList();

  /// Получение данных персонажей.
  ///
  /// Метод принимает номер страницы [page], а также строку [search] для поиска
  /// конкретного персонажа по имени. В случае, если [search] будет пустым,
  /// будут загружены все персонажи.
  Future<void> load({required int page, String search = ''}) async {
    // Игнорируем новую загрузку при выполнении текущей.
    if (state.value.isLoading) return; // || _currentPage == page) return;

    // Очищаем сообщение об ошибке.
    _errorMessage = null;

    // Отображаем экран загрузки.
    state.value = CharactersState.loading;

    try {
      // Загрузка данных персонажей.
      final response = await repository.getCharacters(
        page.clamp(1, _totalPages),
        _lastSearch,
      );
      _characters.addAll(response.results);
      _totalPages = response.info.pages;
      _currentPage = page;

      // Отображаем загруженные [T].
      state.value = CharactersState.idle;
    } on HttpClientException catch (e) {
      // Отображаем ошибки http клиента.
      state.value = CharactersState.error;
      _errorMessage = e.message;

      rethrow;
    } catch (_) {
      // Отображаем прочие ошибки.
      state.value = CharactersState.error;

      rethrow;
    }
  }

  /// Повторная загрузка персонажей.
  Future<void> reload() => _next();

  /// Получение данных персонажей, имя которых содержит [search].
  Future<void> search(String search) async {
    if (_lastSearch != search) {
      _lastSearch = search;
      _position = 0.0;
      _characters.clear();
      await load(page: 1, search: search);
    }
  }

  /// Отслеживание изменения прокрутки списка персонажей.
  Future<void> onScrollChanged(ScrollPosition position) async {
    if (state.value.isLoading || !hasMorePages) return;

    if (position.pixels >= position.maxScrollExtent - 200) {
      // Запоминаем текущую позицию на случай неудачной загрузки.
      _position = position.pixels;

      // Загружаем следующую страницу.
      await _next();
    }
  }

  /// Освобождение занимаемых ресурсов.
  void dispose() {
    state.dispose();
  }

  /// Загрузка следующей страницы персонажей.
  Future<void> _next() async {
    return await load(
      page: math.min(_currentPage + 1, _totalPages),
      search: _lastSearch,
    );
  }
}
