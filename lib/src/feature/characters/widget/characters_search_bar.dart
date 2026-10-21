import 'package:flutter/material.dart';
import 'package:rickandmorty/src/feature/characters/logic/characters_controller.dart';
import 'package:rickandmorty/src/feature/characters/widget/characters_provider.dart';

/// {@template characters_search_bar}
/// Виджет строки поиска персонажей.
/// {@endtemplate}
class CharactersSearchBar extends StatefulWidget {
  /// {@macro characters_screen}
  const CharactersSearchBar({super.key});

  @override
  State<CharactersSearchBar> createState() => _CharactersSearchBarState();
}

class _CharactersSearchBarState extends State<CharactersSearchBar> {
  // Контроллер управления загрузкой персонажей.
  late final CharactersController controller;

  // Контроллер управления строкой поиска персонажей.
  late final TextEditingController textController;

  @override
  void initState() {
    controller = CharactersProvider.of(context);
    textController = TextEditingController();
    textController.addListener(searchListener);
    super.initState();
  }

  // Слушатель изменений в поле поиска.
  Future<void> searchListener() async {
    await controller.search(textController.text);
  }

  @override
  void dispose() {
    textController.removeListener(searchListener);
    textController.dispose();
    super.dispose();
  }

  /// Параметры границы поля поиска.
  InputBorder get border => OutlineInputBorder(
    borderRadius: BorderRadius.circular(24.0),
    borderSide: BorderSide.none,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: textController,
      decoration: InputDecoration(
        fillColor: theme.colorScheme.onPrimary,
        focusColor: theme.colorScheme.onPrimary,
        filled: true,
        border: border,
        focusedBorder: border,
        hintText: 'Find a character',
        hintStyle: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      style: theme.textTheme.titleMedium?.copyWith(
        color: theme.colorScheme.primary,
      ),
      cursorColor: theme.colorScheme.primary,
    );
  }
}
