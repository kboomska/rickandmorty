/// {@template characters_pagination_info}
/// Модель информации о доступных страницах с персонажами.
/// {@endtemplate}
final class CharactersPaginationInfo {
  /// {@macro characters_pagination_info}
  const CharactersPaginationInfo({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  /// Преобразование JSON в экземпляр [CharactersPaginationInfo].
  factory CharactersPaginationInfo.fromJson(Map<String, Object?> json) {
    return CharactersPaginationInfo(
      count: json['count'] as int,
      pages: json['pages'] as int,
      next: json['next'] != null ? json['next'] as String : null,
      prev: json['prev'] != null ? json['prev'] as String : null,
    );
  }

  /// Общее количество персонажей.
  final int count;

  /// Общее количество страниц персонажей.
  final int pages;

  /// Url следующей страницы персонажей.
  final String? next;

  /// Url предыдущей страницы персонажей.
  final String? prev;

  @override
  String toString() {
    return '$CharactersPaginationInfo(count: $count, pages: $pages, next: $next'
        ', prev: $prev)';
  }
}
