import 'package:json_annotation/json_annotation.dart';

import 'channel.dart';
import 'cover_box.dart';

part 'game_stream_legacy.g.dart';

@JsonSerializable()
class GameStream {
  @JsonKey(name: '_id')
  final int id;
  final int viewers;
  @JsonKey(name: 'broadcast_platform')
  final String broadcastPlatform;
  @JsonKey(name: 'stream_type')
  final String streamType;
  @JsonKey(name: 'is_playlist')
  final bool isPlaylist;
  final CoverBox preview;
  final Channel channel;

  GameStream(
      {this.id,
      this.isPlaylist,
      this.viewers,
      this.broadcastPlatform,
      this.streamType,
      this.preview,
      this.channel});

  factory GameStream.fromJson(Map<String, dynamic> json) =>
      _$GameStreamFromJson(json);

  Map<String, dynamic> toJson() => _$GameStreamToJson(this);
}
