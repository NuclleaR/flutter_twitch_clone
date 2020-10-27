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
    Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);

    Response response = await get(uri, headers: tokenManager.getHeaders());
    Map<String, dynamic> json = jsonDecode(response.body);

    if (response.statusCode == HttpStatus.ok) {
      var list = json['data'] as List;
      List<GameStream> streams = list.map((streamJson) => GameStream.fromJson(streamJson)).toList();
      return StreamsResponse(
        cursor: json['pagination']['cursor'],
        list: streams,
      );
    } else {
      throw HttpException(json['message']);
    }

  }

  getFollowedStreams() {

  }
}