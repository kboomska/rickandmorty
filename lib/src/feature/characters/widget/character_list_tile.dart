import 'package:flutter/material.dart';
import 'package:rickandmorty/src/feature/characters/model/character.dart';
import 'package:rickandmorty/src/feature/characters/widget/character_card.dart';

/// {@template characters_list_tile}
/// Виджет элемента списка.
/// {@endtemplate}
class CharacterListTile extends StatelessWidget {
  /// {@macro characters_list_tile}
  const CharacterListTile({
    super.key,
    required this.character,
    required this.isFirst,
    required this.isLast,
    required this.onTap,
  });

  /// Данные персонажа.
  final Character character;

  /// Первый элемент списка.
  final bool isFirst;

  /// Последний элемент списка.
  final bool isLast;

  /// Действие при нажатии на элемент списка.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: isFirst ? 16 : 8,
        bottom: isLast ? 16 : 8,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: CharacterCard(character: character),
      ),
    );
  }
}
