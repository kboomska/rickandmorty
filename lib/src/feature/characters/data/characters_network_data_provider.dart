import 'dart:async' show TimeoutException;
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rickandmorty/src/common/utils/error/network_exception.dart';
import 'package:rickandmorty/src/feature/characters/model/characters_response.dart';

/// Источник данных персонажей.
abstract interface class CharactersDataProvider {
  /// Метод получения данных персонажей.
  Future<CharactersResponse> getCharacters(int page, String name);
}

/// {@template characters_network_data_provider}
/// Поставщик данных персонажей из сети.
/// {@endtemplate}
final class CharactersNetworkDataProvider implements CharactersDataProvider {
  /// {@macro characters_network_data_provider}
  const CharactersNetworkDataProvider({
    required this.client,
    required this.baseUrl,
  });

  /// Ограничение на api-запрос, по истечении которого будет выброшена ошибка.
  static const _timeLimit = Duration(minutes: 1);

  /// HTTP клиент.
  final http.Client client;

  /// Базовый URL источника данных персонажей.
  final String baseUrl;

  /// Загрузка данных персонажей через http.
  ///
  /// Метод принимает номер страницы [page], а также имя (часть имени) [name]
  /// для поиска конкретного персонажа. В случае, если [name] будет пустым,
  /// будут загружены все персонажи.
  @override
  Future<CharactersResponse> getCharacters(int page, String name) async {
    try {
      final response = await client
          .get(Uri.parse('$baseUrl/character/?page=$page&name=$name'))
          .timeout(_timeLimit);

      if (response.statusCode != 200) {
        throw HttpClientException(
          message: response.statusCode == 429
              ? 'Too many requests\nPlease try again later'
              : 'Failed to load characters',
          statusCode: response.statusCode,
        );
      }

      return CharactersResponse.fromJson(
        jsonDecode(response.body) as Map<String, Object?>,
      );
    } on http.ClientException {
      // Для Web сюда могут попадать исключения связанные с 429,
      // но заблокированные браузером из-за CORS.
      throw HttpClientException(
        message: 'Unable to complete the request\nPlease try again later',
      );
    } on TimeoutException {
      throw HttpClientException(message: 'Server request timed out');
    }
  }
}
