import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:twitch_clone/constants/api.dart';
import 'package:twitch_clone/models/models.dart';
import 'package:twitch_clone/responses/responses.dart';
import 'package:twitch_clone/services/services.dart';

class StreamsService {
  final String legacyApiUrl = '$LEGACY_API_URL/streams';
  final String apiUrl = '$API_URL/streams';

  TokenManager tokenManager = getManager(TokenManagerType.twitchTokenManager);

  Future<StreamsResponse> getGameStreams(Map<String, String> params) async {
    Uri uri = Uri.parse(legacyApiUrl).replace(queryParameters: params);
    print(uri);
    Response response = await get(uri, headers: tokenManager.getHeaders());
    Map<String, dynamic> json = jsonDecode(response.body);

    if (response.statusCode == HttpStatus.ok) {
      var list = json['streams'] as List;
      List<GameStream> streams = list.map((streamJson) {
        return GameStream.fromJson(streamJson);
      }).toList();
      return StreamsResponse(
        // cursor: json['pagination']['cursor'],
        total: 900, // 900 value fromm doc
        list: streams,
      );
    } else {
      throw HttpException(json['message']);
    }

  }

  getFollowedStreams() {

  }
}