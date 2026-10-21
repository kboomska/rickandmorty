import 'package:flutter/material.dart';
import 'package:rickandmorty/src/common/utils/debouncer.dart';
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

  // Контроллер управления задержкой выполнения запросов при поиске персонажа.
  late final Debouncer debounce;

  @override
  void initState() {
    controller = CharactersProvider.of(context);
    textController = TextEditingController();
    debounce = Debouncer(milliseconds: 600);
    textController.addListener(searchListener);
    super.initState();
  }

  // Слушатель изменений в поле поиска.
  void searchListener() {
    // Выполнение поиска персонажа по имени после задержки.
    debounce.run(() => controller.search(textController.text.trim()));
  }

  @override
  void dispose() {
    textController.removeListener(searchListener);
    debounce.dispose();
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
