import 'package:json_annotation/json_annotation.dart';

import 'tag.dart';

part 'game_stream_data.g.dart';

@JsonSerializable()
class GameStreamData {
  final String id;

  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'user_name')
  final String userName;

  @JsonKey(name: 'game_id')
  final String gameId;

  final String type;

  final String title;

  @JsonKey(name: 'viewer_count')
  final int viewerCount;

  @JsonKey(name: 'started_at')
  final DateTime startedAt;

  final String language;

  @JsonKey(name: 'thumbnail_url', fromJson: _fromJson, toJson: _toJson)
  final String thumbnailUrl;

  @JsonKey(name: 'tag_ids', defaultValue: [])
  List<String> tagIds;

  GameStreamData(
      {this.id,
      this.userId,
      this.userName,
      this.gameId,
      this.type,
      this.title,
      this.viewerCount,
      this.startedAt,
      this.language,
      this.tagIds,
      this.thumbnailUrl});

  factory GameStreamData.fromJson(Map<String, dynamic> json) =>
      _$GameStreamDataFromJson(json);

  Map<String, dynamic> toJson() => _$GameStreamDataToJson(this);
}

String _fromJson(String data) => data
      .replaceFirst('{width}', '640')
      .replaceFirst('{height}', '360');

String _toJson(data) => data;