import 'package:flutter/material.dart';
import 'package:rickandmorty/src/common/widget/loading_indicator.dart';
import 'package:rickandmorty/src/feature/characters/logic/characters_state.dart';
import 'package:rickandmorty/src/feature/characters/widget/character_list.dart';
import 'package:rickandmorty/src/feature/characters/widget/characters_provider.dart';

/// {@template characters_screen}
/// Виджет экрана персонажей.
/// {@endtemplate}
class CharactersScreen extends StatelessWidget {
  /// {@macro characters_screen}
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CharactersProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Characters')),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: controller.state,
          builder: (context, state, _) {
            final empty = !controller.hasCharacters;
            return switch (state) {
              CharactersState.loading when empty => const LoadingIndicator(),
              CharactersState.idle when empty => const _CharactersEmpty(),
              CharactersState.error => const _CharactersError(),
              _ => const CharacterList(),
            };
          },
        ),
      ),
    );
  }
}

/// {@template _characters_empty}
/// Виджет состояния отсутствия персонажей на экране [CharactersScreen].
/// {@endtemplate}
class _CharactersEmpty extends StatelessWidget {
  /// {@macro _characters_empty}
  const _CharactersEmpty();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No characters',
        style: Theme.of(context).textTheme.bodyLarge
            ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
        textAlign: TextAlign.center,
        maxLines: 2,
      ),
    );
  }
}

/// {@template _characters_error}
/// Виджет состояния ошибки экрана [CharactersScreen].
/// {@endtemplate}
class _CharactersError extends StatelessWidget {
  /// {@macro _characters_error}
  const _CharactersError();

  @override
  Widget build(BuildContext context) {
    final controller = CharactersProvider.of(context);
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: .max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Текст ошибки.
          Flexible(
            fit: .tight,
            flex: 1,
            child: Column(
              mainAxisSize: .max,
              mainAxisAlignment: .end,
              children: [
                Text(
                  'Oops',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                const SizedBox(height: 8.0),
                Text(
                  controller.errorMessage ?? 'Something went wrong',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 4,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          // Кнопка повторной загрузки.
          Flexible(
            flex: 1,
            child: Center(
              child: TextButton.icon(
                onPressed: controller.reload,
                icon: const Icon(Icons.refresh),
                style: ButtonStyle(
                  iconColor: WidgetStatePropertyAll(
                    theme.colorScheme.onPrimary,
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    theme.colorScheme.primary,
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    theme.colorScheme.primary,
                  ),
                ),
                label: Text(
                  'Retry',
                  style: TextStyle(color: theme.colorScheme.onPrimary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
