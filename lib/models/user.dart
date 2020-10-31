import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {

  final String id;
  final String login;
  final String type;
  final String description;
  final String email;

  @JsonKey(name: 'display_name')
  final String displayName;

  @JsonKey(name: 'broadcaster_type')
  final String broadcasterType;

  @JsonKey(name: 'profile_image_url')
  final String profileImageUrl;

  @JsonKey(name: 'offline_image_url')
  final String offlineImageUrl;

  @JsonKey(name: 'view_count')
  final int viewCount;

  User(
      {this.id,
      this.login,
      this.displayName,
      this.type,
      this.broadcasterType,
      this.description,
      this.profileImageUrl,
      this.offlineImageUrl,
      this.viewCount,
      this.email});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
