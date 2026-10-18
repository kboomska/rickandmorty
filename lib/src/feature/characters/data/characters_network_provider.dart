import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rickandmorty/src/feature/characters/model/characters_response.dart';

/// Источник данных персонажей.
abstract interface class CharactersDataProvider {
  /// Получение персонажей из источника данных.
  Future<CharactersResponse> getCharacters();
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

  /// HTTP клиент.
  final http.Client client;

  /// Базовый URL источника данных персонажей.
  final String baseUrl;

  /// Загрузка персонажей из сети.
  @override
  Future<CharactersResponse> getCharacters() async {
    final response = await client.get(Uri.parse('$baseUrl/character'));
    response.headers['content-type'] = 'application/json; charset=utf-8';

    if (response.statusCode == 200) {
      return CharactersResponse.fromJson(
        jsonDecode(response.body) as Map<String, Object?>,
      );
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
