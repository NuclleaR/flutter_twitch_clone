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
      this.thumbnailUrl});

  factory GameStream.fromJson(Map<String, dynamic> json) {
    return GameStream(
        id: json['id'],
        userId: json['user_id'],
        userName: json['user_name'],
        gameId: json['game_id'],
        type: json['type'],
        title: json['title'],
      viewerCount: json['viewer_count'],
      startedAt: DateTime.parse(json['started_at']),
      language: json['language'],
      thumbnailUrl: (json['thumbnail_url'] as String)
          .replaceFirst('{width}', '640')
          .replaceFirst('{height}', '360'),
    );
  }
}
