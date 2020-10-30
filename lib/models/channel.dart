import 'package:json_annotation/json_annotation.dart';

part 'channel.g.dart';

@JsonSerializable()
class Channel {
  @JsonKey(name: '_id')
  final int id;
  final String status;
  @JsonKey(name: 'display_name')
  final String displayName;
  final String name;
  final String game;
  final String description;
  @JsonKey(name: 'broadcaster_language')
  final String broadcasterLanguage;
  final String language;
  final String logo;
  @JsonKey(name: 'video_banner')
  final String videoBanner;
  @JsonKey(name: 'profile_banner')
  final String profileBanner;
  final String url;
  final int views;
  final int followers;

  Channel(
      {this.id,
      this.status,
      this.displayName,
      this.name,
      this.game,
      this.description,
      this.broadcasterLanguage,
      this.language,
      this.logo,
      this.videoBanner,
      this.profileBanner,
      this.url,
      this.views,
      this.followers});

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['_id'],
      status: json['status'],
      name: json['name'],
      displayName: json['display_name'],
      game: json['game'],
      description: json['description'],
      language: json['language'],
      broadcasterLanguage: json['broadcaster_language'],
      logo: json['logo'],
      videoBanner: json['video_banner'],
      profileBanner: json['profile_banner'],
      url: json['url'],
      views: json['views'],
      followers: json['followers'],
    );
  }
}
