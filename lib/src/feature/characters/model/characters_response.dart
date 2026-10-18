import 'package:rickandmorty/src/feature/characters/model/character.dart';
import 'package:rickandmorty/src/feature/characters/model/characters_pagination_info.dart';

/// {@template characters_response}
/// Модель данных о персонажах.
/// {@endtemplate}
final class CharactersResponse {
  /// {@macro characters_response}
  const CharactersResponse({required this.info, required this.results});

  /// Преобразование JSON в экземпляр [CharactersResponse].
  factory CharactersResponse.fromJson(Map<String, Object?> json) {
    return CharactersResponse(
      info: CharactersPaginationInfo.fromJson(
        json['info'] as Map<String, Object?>,
      ),
      results: List.from(
        (json['results'] as List<Object?>).map(
          (character) => Character.fromJson(character as Map<String, Object?>),
        ),
      ),
    );
  }

  /// Информация о доступных страницах с персонажами.
  final CharactersPaginationInfo info;

  /// Список загруженных персонажей.
  final List<Character> results;

  @override
  String toString() => '$CharactersResponse(info: $info, results: $results)';
}
