import 'package:flutter/foundation.dart';
import 'package:twitch_clone/auth/auth.dart';

import 'storage.dart';
import 'token_manager.dart';

enum TokenManagerType { twitchTokenManager }

Map<TokenManagerType, Map<String, dynamic>> _params = {
  TokenManagerType.twitchTokenManager: {
    'client': TwitchClient(
      clientId: "htjh1khsxsxj4ofsoxmiubct9iavxo",
      clientSecret: "o13lshhr4f74qavdl6adzk6anl3fy4",
      callbackUrlScheme: "com.example.twitchClone",
      scopes: "user:read:email user:edit:follows user_read",
    ),
    'storage': TokenStorage('twitchToken'),
  }
};

TokenManager getManager(TokenManagerType type) {
  TokenManager tokenManager = TokenManager(
      name: describeEnum(type),
      client: _params[TokenManagerType.twitchTokenManager]['client'],
      storage: _params[TokenManagerType.twitchTokenManager]['storage']);

  return tokenManager;
}
