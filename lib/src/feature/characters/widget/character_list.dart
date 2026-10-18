import 'package:flutter/material.dart';
import 'package:rickandmorty/src/feature/characters/logic/characters_controller.dart';
import 'package:rickandmorty/src/feature/characters/widget/character_card.dart';
import 'package:rickandmorty/src/feature/characters/widget/characters_provider.dart';

/// {@template characters_list}
/// Виджет отображаемого списка персонажей.
/// {@endtemplate}
class CharacterList extends StatefulWidget {
  /// {@macro characters_list}
  const CharacterList({super.key});

  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  // Контроллер прокрутки экрана персонажей.
  late final ScrollController scrollController;

  // Контроллер управления загрузкой персонажей.
  late final CharactersController controller;

  @override
  void initState() {
    controller = CharactersProvider.of(context);
    scrollController = ScrollController(
      initialScrollOffset: controller.scrollPosition,
    );
    scrollController.addListener(scrollListener);
    super.initState();
  }

  /// Отслеживание изменения прокрутки списка персонажей.
  void scrollListener() {
    // Использование метода addPostFrameCallback позволяет избежать ошибок
    // вызова обновления виджета до завершения текущей его отрисовки.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        await controller.onScrollChanged(scrollController.position);
      }
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.state,
      builder: (context, state, _) {
        final characters = controller.characters;

        return ListView.builder(
          controller: scrollController,
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
