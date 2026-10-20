/// {@template character_location}
/// Модель локации персонажа.
/// {@endtemplate}
final class CharacterLocation {
  /// {@macro character_location}
  const CharacterLocation({required this.name, required this.url});

  /// Преобразование JSON в экземпляр [CharacterLocation].
  factory CharacterLocation.fromJson(Map<String, Object?> json) {
    return CharacterLocation(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  /// Название локации.
  final String name;

  /// Url подробных данных о локации.
  final String url;

  @override
  String toString() => '$CharacterLocation(name: $name, url: $url)';
}
