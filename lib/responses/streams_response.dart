import 'package:twitch_clone/models/models.dart';

class StreamsResponse {
  final List<GameStream> list;
  final String cursor;
  final int total;

  StreamsResponse({ this.list, this.cursor, this.total });
}