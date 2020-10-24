import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:twitch_clone/models/models.dart';
import 'package:twitch_clone/responses/responses.dart';

import 'manager_factory.dart';
import 'token_manager.dart';

class GameService {
  final String apiUrl = 'https://api.twitch.tv/helix';
  final String legacyApiUrl = 'https://api.twitch.tv/kraken';

  TokenManager tokenManager = getManager(TokenManagerType.twitchTokenManager);

  Future<GamesResponse> getGames({Map<String, String> queryParameters}) async {
    try {
      Response response = await get(
          Uri.parse('$legacyApiUrl/games/top')
              .replace(queryParameters: queryParameters),
          headers: {
            'Accept': 'application/vnd.twitchtv.v5+json',
            ...tokenManager.getHeaders(),
          });

      var rawResponse = jsonDecode(response.body);

      // print('body: ${response.body}');

      if (response.statusCode == HttpStatus.ok) {
        var list = rawResponse['top'] as List;
        List<Game> games =
            list.map((gameJson) => Game.fromJson(gameJson)).toList();
        return GamesResponse(list: games, total: rawResponse['_total']);
        // return GamesResponse(games, rawResponse['pagination']['cursor']);
      } else {
        throw HttpException(rawResponse['message']);
      }
    } catch (ex) {
      rethrow;
    }
  }
}
