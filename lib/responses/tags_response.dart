import 'package:twitch_clone/models/models.dart';

class TagsResponse {
  final Map<String, Tag> map;
  final String cursor;
  final int total;

  TagsResponse({ this.map, this.cursor, this.total });
}