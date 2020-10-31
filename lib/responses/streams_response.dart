import 'package:twitch_clone/models/models.dart';

class StreamsResponse {
  final List<GameStreamData> list;
  final String cursor;
  final int total;
  final Map<String, Tag> tags;
  final Map<String, User> users;

  StreamsResponse({ this.list, this.tags, this.users, this.cursor, this.total });
}