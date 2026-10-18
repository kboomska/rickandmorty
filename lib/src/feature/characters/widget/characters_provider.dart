import 'package:flutter/widgets.dart';
import 'package:rickandmorty/src/feature/characters/logic/characters_controller.dart';

/// {@template characters_provider}
/// Класс для внедрения контроллера [CharactersController] в [BuildContext].
/// {@endtemplate}
class CharactersProvider extends InheritedWidget {
  /// {@macro characters_provider}
  const CharactersProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  /// Контроллер управления загрузкой персонажей.
  final CharactersController controller;

  /// {@template characters_provider_maybe_of}
  /// Метод возвращает экземпляр [CharactersController] из ближайшего по дереву
  /// виджета [CharactersProvider].
  /// {@endtemplate}
  static CharactersController? maybeOf(BuildContext context) =>
      context.getInheritedWidgetOfExactType<CharactersProvider>()?.controller;

  /// {@macro characters_provider_maybe_of}
  ///
  /// Если [CharactersProvider] не будет найден в дереве виджетов, вернет ошибку.
  static CharactersController of(BuildContext context) =>
      maybeOf(context) ??
      (throw ArgumentError('No $CharactersController found in context'));

  @override
  bool updateShouldNotify(CharactersProvider oldWidget) => false;
}
