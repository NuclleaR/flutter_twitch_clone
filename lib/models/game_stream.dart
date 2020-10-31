import 'models.dart';
import 'game_stream_data.dart';

class GameStream {
  final String id;
  final String userId;
  final String userName;
  final String gameId;
  final String type;
  final String title;
  final int viewerCount;
  final DateTime startedAt;
  final String language;
  final String thumbnailUrl;
  final List<Tag> tagList;
  final User user;

  GameStream(
      {this.id,
      this.userId,
      this.userName,
      this.gameId,
      this.type,
      this.title,
      this.viewerCount,
      this.startedAt,
      this.language,
      this.tagList,
      this.user,
      this.thumbnailUrl});

  factory GameStream.fromData(
          GameStreamData streamData, Map<String, Tag> tags, User user) =>
      GameStream(
          id: streamData.id,
          userId: streamData.userId,
          userName: streamData.userName,
          gameId: streamData.gameId,
          type: streamData.type,
          title: streamData.title,
          viewerCount: streamData.viewerCount,
          startedAt: streamData.startedAt,
          language: streamData.language,
          thumbnailUrl: streamData.thumbnailUrl,
          user: user,
          tagList: streamData.tagIds.map((String id) => tags[id]).toList());
}
