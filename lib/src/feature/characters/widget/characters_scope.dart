import 'package:flutter/material.dart';
import 'package:rickandmorty/src/feature/characters/data/characters_repository.dart';
import 'package:rickandmorty/src/feature/characters/logic/characters_controller.dart';
import 'package:rickandmorty/src/feature/characters/widget/characters_provider.dart';

/// {@template characters_scope}
/// Виджет управления областью видимости зависимостей для экрана персонажей.
/// {@endtemplate}
class CharactersScope extends StatefulWidget {
  /// {@macro characters_scope}
  const CharactersScope({
    super.key,
    required this.repository,
    required this.child,
  });

  /// Репозиторий доступа к данным персонажей.
  final CharactersRepository repository;

  /// Дочерний виджет, которому будут доступны зависимости.
  final Widget child;

  @override
  State<CharactersScope> createState() => _CharactersScopeState();
}

class _CharactersScopeState extends State<CharactersScope> {
  // Контроллер управления загрузкой персонажей.
  late final CharactersController controller;

  @override
  void initState() {
    controller = CharactersController(repository: widget.repository);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CharactersProvider(
      // Передаем контроллер и сразу загружаем список персонажей.
      controller: controller..load(),
      child: widget.child,
    );
  }
}
