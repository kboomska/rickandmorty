import 'package:flutter/material.dart';
import 'package:rickandmorty/src/feature/characters/model/character.dart';

/// {@template character_card}
/// Виджет карточки персонажа в списке.
/// {@endtemplate}
class CharacterCard extends StatelessWidget {
  /// {@macro character_card}
  const CharacterCard({super.key, required this.character});

  /// Данные персонажа.
  final Character character;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        border: Border.all(color: theme.colorScheme.secondary, width: 1),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: .center,
          children: [
            // Изображение персонажа.
            Image.network(
              character.image,
              height: 80,
              width: 80,
              errorBuilder: (_, _, _) => Image.asset(
                "assets/images/empty.webp",
                height: 80,
                width: 80,
              ),
            ),
            const SizedBox.square(dimension: 16),
            // Данные персонажа.
            Flexible(
              fit: .tight,
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    character.name,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 1,
                      ),
                      child: Text(
                        character.status.upperName,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: theme.colorScheme.onPrimary),
          ],
        ),
      ),
    );
  }
}
