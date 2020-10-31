import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:twitch_clone/constants/api.dart';
import 'package:twitch_clone/models/models.dart';
import 'package:twitch_clone/responses/responses.dart';
import 'package:twitch_clone/services/services.dart';

import 'tags_service.dart';

class StreamsService {
  // final String legacyApiUrl = '$LEGACY_API_URL/streams';
  final String apiUrl = '$API_URL/streams';

  final TagsService _tagsService = TagsService();
  final UsersService _usersService = UsersService();
  final TokenManager tokenManager = getManager(TokenManagerType.twitchTokenManager);

  Future<StreamsResponse> getGameStreams(Map<String, String> params) async {
    Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);
    print(uri);
    Response response = await get(uri, headers: tokenManager.getHeaders());
    Map<String, dynamic> json = jsonDecode(response.body);

    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> map = _processResponse(json);

      List<dynamic> responses = await Future.wait([
        _tagsService.getTags(map['tags'].toList()),
        _usersService.getUsers(map['userIds'])
      ]);

      return StreamsResponse(
        cursor: json['pagination']['cursor'],
        list: map['streams'],
        tags: (responses[0] as TagsResponse).map,
        users: (responses[1] as UsersResponse).map,
      );
    } else {
      throw HttpException(json['message']);
    }
  }

  Map<String, dynamic> _processResponse(Map<String, dynamic> json) {
    List<Map<String, dynamic>> list = List<Map<String, dynamic>>.from(json['data']);

    Set<String> tags = Set();
    List<String> userIds = [];
    List<GameStreamData> streams = [];

    list.forEach((Map<String, dynamic> streamJson) {

      userIds.add(streamJson['user_id']);
      streams.add(GameStreamData.fromJson(streamJson));

      List<String> tagIds = List<String>.from(streamJson['tag_ids']);

      tagIds.forEach((String id) {
        tags.add(id);
      });
    });

    return {
      'tags': tags,
      'userIds': userIds,
      'streams': streams,
    };
  }
}