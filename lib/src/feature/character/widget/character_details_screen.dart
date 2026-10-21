import 'package:flutter/material.dart';
import 'package:rickandmorty/src/feature/character/widget/character_image.dart';
import 'package:rickandmorty/src/feature/characters/model/character.dart';

/// {@template character_details_screen}
/// Виджет экрана подробной информации о персонаже.
/// {@endtemplate}
class CharacterDetailsScreen extends StatelessWidget {
  /// {@macro character_details_screen}
  const CharacterDetailsScreen({super.key, required this.character});

  /// Данные персонажа.
  final Character character;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Details', overflow: .ellipsis)),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .center,
          children: [
            // Изображение персонажа.
            Flexible(child: CharacterImage(imageUrl: character.image)),
            const SizedBox(height: 8.0),
            // Описание персонажа.
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: .start,
                    crossAxisAlignment: .start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          character.name,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: .center,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Column(
                            mainAxisAlignment: .start,
                            crossAxisAlignment: .start,
                            children: [
                              _CharacterDetails(
                                details:
                                    'Status: ${character.status.upperName}',
                                topPadding: 0,
                              ),
                              _CharacterDetails(
                                details: 'Species: ${character.species}',
                              ),
                              _CharacterDetails(
                                details: 'Origin: ${character.origin.name}',
                              ),
                              _CharacterDetails(
                                details: 'Location: ${character.location.name}',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// {@template _character_details}
/// Виджет описания персонажа.
/// {@endtemplate}
class _CharacterDetails extends StatelessWidget {
  /// {@macro _character_details}
  const _CharacterDetails({required this.details, this.topPadding = 8.0});

  /// Описание персонажа.
  final String details;

  /// Отступ сверху.
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          details,
          maxLines: 2,
          overflow: .ellipsis,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
