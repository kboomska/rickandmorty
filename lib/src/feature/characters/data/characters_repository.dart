import 'package:rickandmorty/src/feature/characters/data/characters_network_data_provider.dart';
import 'package:rickandmorty/src/feature/characters/model/characters_response.dart';

/// Репозиторий доступа к данным персонажей.
abstract interface class CharactersRepository {
  /// Получение персонажей из источника данных.
  Future<CharactersResponse> getCharacters(int page);
}

/// {@template characters_repository_impl}
/// Репозиторий доступа к данным персонажей.
/// {@endtemplate}
final class CharactersRepositoryImpl implements CharactersRepository {
  /// {@macro characters_repository_impl}
  const CharactersRepositoryImpl({required this.dataProvider});

  /// Источник данных персонажей.
  final CharactersDataProvider dataProvider;

  /// Получение персонажей.
  @override
  Future<CharactersResponse> getCharacters(int page) =>
      dataProvider.getCharacters(page);
}
