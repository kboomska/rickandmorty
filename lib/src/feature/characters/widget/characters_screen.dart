import 'package:flutter/material.dart';
import 'package:rickandmorty/src/feature/characters/logic/characters_state.dart';
import 'package:rickandmorty/src/feature/characters/widget/character_list.dart';
import 'package:rickandmorty/src/feature/characters/widget/characters_provider.dart';

/// {@template characters_screen}
/// Виджет экрана персонажей [CharactersScreen].
/// {@endtemplate}
class CharactersScreen extends StatelessWidget {
  /// {@macro characters_screen}
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Characters')),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ValueListenableBuilder(
        valueListenable: CharactersProvider.of(context).state,
        builder: (context, state, _) {
          return switch (state) {
            CharactersState.loading => const _CharactersScreen$Loading(),
            CharactersState.idle => const _CharactersScreen$Idle(),
            CharactersState.error => const _CharactersScreen$Error(),
          };
        },
      ),
    );
  }
}

/// {@template _character_screen_idle}
/// Виджет состояния ожидания (покоя) для экрана [CharactersScreen].
/// {@endtemplate}
class _CharactersScreen$Idle extends StatelessWidget {
  /// {@macro _character_screen_idle}
  const _CharactersScreen$Idle();

  @override
  Widget build(BuildContext context) {
    final controller = CharactersProvider.of(context);

    return ValueListenableBuilder(
      valueListenable: controller.state,
      builder: (context, state, child) {
        return controller.hasCharacters
            // Список персонажей.
            ? child!
            // Текст уведомления пользователя об отсутствии персонажей.
            : Center(
                child: Text(
                  'No characters',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              );
      },
      child: const CharacterList(),
    );
  }
}

/// {@template _character_screen_loading}
/// Виджет состояния загрузки экрана [CharactersScreen].
/// {@endtemplate}
class _CharactersScreen$Loading extends StatelessWidget {
  /// {@macro _character_screen_loading}
  const _CharactersScreen$Loading();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: 40,
        child: RepaintBoundary(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}

/// {@template _character_screen_error}
/// Виджет состояния ошибки экрана [CharactersScreen].
/// {@endtemplate}
class _CharactersScreen$Error extends StatelessWidget {
  /// {@macro _character_screen_error}
  const _CharactersScreen$Error();

  @override
  Widget build(BuildContext context) {
    final controller = CharactersProvider.of(context);
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Текст ошибки.
          Flexible(
            child: Text(
              'Something went wrong',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
          const SizedBox(height: 16),
          // Кнопка повторной загрузки.
          TextButton.icon(
            onPressed: controller.reload,
            icon: const Icon(Icons.refresh),
            style: ButtonStyle(
              iconColor: WidgetStatePropertyAll(theme.colorScheme.onPrimary),
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
        ],
      ),
    );
  }
}
