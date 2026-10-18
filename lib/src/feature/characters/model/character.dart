/// {@template character}
/// Модель персонажа.
/// {@endtemplate}
final class Character {
  /// {@macro character}
  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.image,
  });

  /// Преобразование JSON в экземпляр [Character].
  factory Character.fromJson(Map<String, Object?> json) {
    return Character(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      image: json['image'] as String,
    );
  }

  /// Идентификатор персонажа.
  final int id;

  /// Имя персонажа.
  final String name;

  /// Статус персонажа.
  final String status;

  /// Url изображения персонажа.
  final String image;

  @override
  String toString() {
    return '$Character(id: $id, name: $name, status: $status, image: $image)';
  }
}
