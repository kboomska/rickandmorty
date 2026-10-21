import 'dart:async';

/// {@template debouncer}
/// [Debouncer] позволяет выполнять вызов функций с помощью метода [run] по
/// истечении указанной задержки [milliseconds].
/// {@endtemplate}
class Debouncer {
  /// {@macro debouncer}
  Debouncer({required this.milliseconds});

  /// Задержка выполнения.
  final int milliseconds;

  /// Таймер выполнения.
  Timer? _timer;

  /// Метод вызова функции [action] с задержкой.
  void run(void Function() action) {
    dispose();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  /// Очистка занимаемых ресурсов.
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
