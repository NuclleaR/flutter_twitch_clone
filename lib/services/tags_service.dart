import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:twitch_clone/constants/api.dart';
import 'package:twitch_clone/models/models.dart';
import 'package:twitch_clone/responses/responses.dart';

import 'manager_factory.dart';
import 'services.dart';

class TagsService {
  final String apiUrl = '$API_URL/tags/streams';
  final TokenManager tokenManager = getManager(TokenManagerType.twitchTokenManager);

  Future<TagsResponse> getTags(List<String> tagIds) async {

    String url = _getUrl(tagIds);

    Response response = await get(url, headers: tokenManager.getHeaders());

    Map<String, dynamic> json = jsonDecode(response.body);

    if (response.statusCode == HttpStatus.ok) {
      Map<String, Tag> tagsMap = Map.fromIterable(
          json['data'],
          key: (element) => element['tag_id'],
          value: (element) => Tag.fromJson(element)
      );

      return TagsResponse(
        map: tagsMap,
        cursor: json['pagination']['cursor'],
      );
    } else {
      throw HttpException(json['message']);
    }
  }

  String _getUrl(List<String> tags) {
    String url = '$apiUrl?tag_id=';
    return url + tags.reduce((value, element) => '$value&tag_id=$element');
  }
}