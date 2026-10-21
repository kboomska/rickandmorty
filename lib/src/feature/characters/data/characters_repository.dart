import 'package:rickandmorty/src/feature/characters/data/characters_network_data_provider.dart';
import 'package:rickandmorty/src/feature/characters/model/characters_response.dart';

/// Репозиторий доступа к данным персонажей.
abstract interface class CharactersRepository {
  /// Метод получения данных персонажей.
  Future<CharactersResponse> getCharacters(int page, String name);
}

/// {@template characters_repository_impl}
/// Репозиторий доступа к данным персонажей.
/// {@endtemplate}
final class CharactersRepositoryImpl implements CharactersRepository {
  /// {@macro characters_repository_impl}
  const CharactersRepositoryImpl({required this.dataProvider});

  /// Источник данных персонажей.
  final CharactersDataProvider dataProvider;

  /// Получение данных персонажей.
  ///
  /// Метод принимает номер страницы [page], а также имя (часть имени) [name]
  /// для поиска конкретного персонажа. В случае, если [name] будет пустым,
  /// будут загружены все персонажи.
  @override
  Future<CharactersResponse> getCharacters(int page, String name) =>
      dataProvider.getCharacters(page, name);
}
