import 'oauth2_client.dart';

class TwitchClient extends Oauth2Client {
  String authUrl = "https://id.twitch.tv/oauth2/authorize";
  String tokenUrl = "https://id.twitch.tv/oauth2/token";

  TwitchClient(
      {String clientId,
      String clientSecret,
      String callbackUrlScheme,
      String scopes})
      : super(
            clientId: clientId,
            clientSecret: clientSecret,
            callbackUrlScheme: callbackUrlScheme,
            scopes: scopes);

  factory TwitchClient.fromMap(Map<String, String> map) {
    return TwitchClient(
      clientId: map['clientId'],
      clientSecret: map['clientSecret'],
      callbackUrlScheme: map['callbackUrlScheme'],
      scopes: map['scopes'],
    );
  }
}
