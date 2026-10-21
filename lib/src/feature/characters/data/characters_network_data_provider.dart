import 'dart:async' show TimeoutException;
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rickandmorty/src/common/utils/error/network_exception.dart';
import 'package:rickandmorty/src/feature/characters/model/characters_response.dart';

/// Источник данных персонажей.
abstract interface class CharactersDataProvider {
  /// Получение персонажей из источника данных.
  Future<CharactersResponse> getCharacters(int page);
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

  /// Загрузка персонажей из сети.
  @override
  Future<CharactersResponse> getCharacters(int page) async {
    try {
      final response = await client
          .get(Uri.parse('$baseUrl/character/?page=$page'))
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
