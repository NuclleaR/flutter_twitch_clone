import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:twitch_clone/constants/api.dart';
import 'package:twitch_clone/models/models.dart';
import 'package:twitch_clone/responses/responses.dart';

import 'manager_factory.dart';
import 'token_manager.dart';

class GameService {
  final String apiUrl = '$LEGACY_API_URL/games/top';

  TokenManager tokenManager = getManager(TokenManagerType.twitchTokenManager);

  Future<GamesResponse> getGames({Map<String, String> queryParameters}) async {
    try {
      Response response = await get(
          Uri.parse(apiUrl)
              .replace(queryParameters: queryParameters),
          headers: tokenManager.getHeaders(isLegacy: true));

      var rawResponse = jsonDecode(response.body);

      if (response.statusCode == HttpStatus.ok) {
        var list = rawResponse['top'] as List;
        List<Game> games =
            list.map((gameJson) {
              Map<String, dynamic> json = Map.from(gameJson['game']);
              json['viewers'] = gameJson['viewers'];
              json['channels'] = gameJson['channels'];
              return Game.fromJson(json);
            }).toList();
        return GamesResponse(list: games, total: rawResponse['_total']);
      } else {
        throw HttpException(rawResponse['message']);
      }
    } catch (ex) {
      rethrow;
    }
  }
}
