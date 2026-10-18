/// Статус персонажа.
enum CharacterStatus {
  alive,
  dead,
  unknown;

  /// Определение допустимого статуса [CharacterStatus] по названию [name].
  ///
  /// Если статус [name] не найден, возвращает [CharacterStatus.unknown].
  static CharacterStatus byName(String? name) {
    if (name == null || name.isEmpty) {
      return CharacterStatus.unknown;
    } else {
      return CharacterStatus.values.firstWhere(
        (status) => status.name == name.toLowerCase(),
        orElse: () => CharacterStatus.unknown,
      );
    }
  }
}
