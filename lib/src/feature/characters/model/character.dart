import 'package:rickandmorty/src/feature/characters/logic/character_status.dart';
import 'package:rickandmorty/src/feature/characters/model/character_location.dart';

/// {@template character}
/// Модель персонажа.
/// {@endtemplate}
final class Character {
  /// {@macro character}
  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.origin,
    required this.location,
    required this.image,
  });

  /// Преобразование JSON в экземпляр [Character].
  factory Character.fromJson(Map<String, Object?> json) {
    return Character(
      id: json['id'] as int,
      name: json['name'] as String,
      status: CharacterStatus.byName(json['status'] as String),
      species: json['species'] as String,
      origin: CharacterLocation.fromJson(
        json['origin'] as Map<String, Object?>,
      ),
      location: CharacterLocation.fromJson(
        json['location'] as Map<String, Object?>,
      ),
      image: json['image'] as String,
    );
  }

  /// Идентификатор персонажа.
  final int id;

  /// Имя персонажа.
  final String name;

  /// Статус персонажа.
  final CharacterStatus status;

  /// Вид персонажа.
  final String species;

  /// Происхождение персонажа.
  final CharacterLocation origin;

  /// Местоположение персонажа.
  final CharacterLocation location;

  /// Url изображения персонажа.
  final String image;

  @override
  String toString() {
    return '$Character(id: $id, name: $name, status: $status, species: $species'
        ', origin: $origin, location: $location, image: $image)';
  }
}
