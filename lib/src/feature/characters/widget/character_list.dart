import 'package:flutter/material.dart';
import 'package:rickandmorty/src/common/widget/loading_indicator.dart';
import 'package:rickandmorty/src/feature/character/widget/character_details_screen.dart';
import 'package:rickandmorty/src/feature/characters/logic/characters_controller.dart';
import 'package:rickandmorty/src/feature/characters/model/character.dart';
import 'package:rickandmorty/src/feature/characters/widget/character_list_tile.dart';
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
  // Контроллер управления загрузкой персонажей.
  late final CharactersController controller;

  // Контроллер прокрутки экрана персонажей.
  late final ScrollController scrollController;

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

  /// Переход к экрану выбранного персонажа.
  Future<void> moveToCharacter({
    required BuildContext context,
    required Character character,
  }) => Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (context) => CharacterDetailsScreen(character: character),
    ),
  );

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
        final items = controller.characters.length;

        return ListView.builder(
          controller: scrollController,
          itemCount: items + (controller.hasMorePages ? 1 : 0),
          itemBuilder: (context, index) {
            final tiles = items - (controller.hasMorePages ? 0 : 1);

            return index < items
                ? CharacterListTile(
                    key: ValueKey(controller.characters[index].id),
                    character: controller.characters[index],
                    isFirst: index == 0,
                    isLast: index == tiles,
                    onTap: () => moveToCharacter(
                      context: context,
                      character: controller.characters[index],
                    ),
                  )
                : const LoadingIndicator();
          },
        );
      },
    );
  }
}
