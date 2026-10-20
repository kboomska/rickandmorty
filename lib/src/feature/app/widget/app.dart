import 'package:flutter/material.dart';
import 'package:rickandmorty/src/common/theme/color_scheme.dart';
import 'package:rickandmorty/src/feature/characters/data/characters_repository.dart';
import 'package:rickandmorty/src/feature/characters/widget/characters_scope.dart';
import 'package:rickandmorty/src/feature/characters/widget/characters_screen.dart';

/// {@template app}
/// Виджет [App] представляет точку входа в приложение.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({super.key, required this.repository});

  /// Единственный глобальный ключ, необходимый для корректной работы
  /// [MaterialApp] при включении Flutter Inspector (избежание перестроения
  /// дерева виджетов).
  static final _globalKey = GlobalKey();

  /// Репозиторий доступа к данным персонажей.
  final CharactersRepository repository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: _globalKey,
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(colorScheme: colorScheme),
      home: const CharactersScreen(),
      builder: (context, child) => MediaQuery.withClampedTextScaling(
        minScaleFactor: 1.0,
        maxScaleFactor: 2.0,
        child: CharactersScope(repository: repository, child: child!),
      ),
    );
  }
}
