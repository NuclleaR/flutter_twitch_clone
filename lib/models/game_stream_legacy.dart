import 'channel.dart';
import 'cover_box.dart';

class GameStream {
  final int id;
  final int viewers;
  final String broadcastPlatform;
  final String streamType;
  final CoverBox preview;
  final Channel channel;

  GameStream(
      {this.id,
      this.viewers,
      this.broadcastPlatform,
      this.streamType,
      this.preview,
      this.channel});

  factory GameStream.fromJson(Map<String, dynamic> json) {
    Channel channel = Channel.fromJson(json['channel']);
    CoverBox preview = CoverBox.fromJson(json['preview']);
    return GameStream(
        id: json['_id'],
        viewers: json['viewers'],
        broadcastPlatform: json['broadcast_platform'],
        streamType: json['streamType'],
        channel: channel,
        preview: preview);
  }
}
