/// Состояние экрана персонажей.
enum CharactersState {
  /// Ожидание.
  idle,

  /// Загрузка.
  loading,

  /// Ошибка.
  error;

  /// Текущее состояние загрузки.
  bool get isLoading => this == loading;

  /// Текущее состояние ошибки.
  bool get isError => this == error;
}
