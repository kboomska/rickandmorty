import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rickandmorty/src/common/utils/error/network_exception.dart';
import 'package:rickandmorty/src/feature/characters/model/characters_response.dart';

/// Источник данных персонажей.
abstract interface class CharactersDataProvider {
  /// Получение персонажей из источника данных.
  Future<CharactersResponse> getCharacters(int page);
}

/// {@template characters_network_provider}
/// Поставщик данных персонажей из сети.
/// {@endtemplate}
final class CharactersNetworkProvider implements CharactersDataProvider {
  /// {@macro characters_network_provider}
  const CharactersNetworkProvider({
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
    final response = await client
        .get(Uri.parse('$baseUrl/character/?page=$page'))
        .timeout(_timeLimit);

    if (response.statusCode == 200) {
      return CharactersResponse.fromJson(
        jsonDecode(response.body) as Map<String, Object?>,
      );
    } else if (response.statusCode == 429) {
      throw HttpClientException(
        message: 'The server is overloaded\nPlease wait',
      );
    } else {
      throw HttpClientException(message: 'Failed to load characters');
    }
  }
}
