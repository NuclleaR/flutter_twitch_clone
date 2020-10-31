import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:twitch_clone/constants/api.dart';
import 'package:twitch_clone/models/models.dart';
import 'package:twitch_clone/responses/responses.dart';

import 'manager_factory.dart';
import 'services.dart';

class UsersService {
  final String apiUrl = '$API_URL/users';
  final TokenManager tokenManager = getManager(TokenManagerType.twitchTokenManager);

  Future<UsersResponse> getUsers(List<String> ids) async {

    String url = _getUrl(ids);

    Response response = await get(url, headers: tokenManager.getHeaders());

    Map<String, dynamic> json = jsonDecode(response.body);

    if (response.statusCode == HttpStatus.ok) {
      Map<String, User> usersMap = Map.fromIterable(
          json['data'],
          key: (element) => element['id'],
          value: (element) => User.fromJson(element)
      );

      return UsersResponse(usersMap);
    } else {
      throw HttpException(json['message']);
    }
  }

  String _getUrl(List<String> ids) {
    String url = '$apiUrl?id=';
    return url + ids.reduce((value, element) => '$value&id=$element');
  }
}