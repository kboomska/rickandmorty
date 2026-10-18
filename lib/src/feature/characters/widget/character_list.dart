import 'package:flutter/material.dart';
import 'package:rickandmorty/src/feature/characters/widget/character_card.dart';
import 'package:rickandmorty/src/feature/characters/widget/characters_provider.dart';

/// {@template characters_list}
/// Виджет отображаемого списка персонажей.
/// {@endtemplate}
class CharacterList extends StatelessWidget {
  /// {@macro characters_list}
  const CharacterList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CharactersProvider.of(context);

    return ValueListenableBuilder(
      valueListenable: controller.state,
      builder: (context, state, _) {
        final characters = controller.characters;

        return ListView.builder(
          itemCount: characters.length,
          itemBuilder: (context, index) {
            final isFirst = index == 0;
            final isLast = index == characters.length - 1;
            final character = characters[index];

            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: isFirst ? 16 : 8,
                bottom: isLast ? 16 : 8,
              ),
              child: CharacterCard(
                key: ValueKey(character.id),
                character: character,
              ),
            );
          },
        );
      },
    );
  }
}
