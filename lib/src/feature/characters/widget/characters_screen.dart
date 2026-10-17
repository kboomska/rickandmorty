import 'package:flutter/material.dart';

/// {@template characters_screen}
/// Виджет экрана персонажей [CharactersScreen].
/// {@endtemplate}
class CharactersScreen extends StatelessWidget {
  /// {@macro characters_screen}
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Characters'));
  }
}
