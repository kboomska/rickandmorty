import 'package:flutter/material.dart';
import 'package:rickandmorty/src/feature/characters/widget/characters_screen.dart';

/// {@template material_context}
/// Виджет [MaterialContext] представляет точку входа в контекст (context).
/// {@endtemplate}
class MaterialContext extends StatelessWidget {
  /// {@macro material_context}
  const MaterialContext({super.key});

  /// Единственный глобальный ключ, необходимый для корректной работы
  /// [MaterialApp] при включении Flutter Inspector (избежание перестроения
  /// дерева виджетов).
  static final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: _globalKey,
      debugShowCheckedModeBanner: false,
      home: const CharactersScreen(),
      builder: (context, child) => MediaQuery.withClampedTextScaling(
        minScaleFactor: 1.0,
        maxScaleFactor: 2.0,
        child: child!,
      ),
    );
  }
}
