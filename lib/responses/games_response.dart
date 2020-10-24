import 'package:twitch_clone/models/models.dart';

class GamesResponse {
  final List<Game> list;
  final String cursor;
  final int total;

  GamesResponse({ this.list, this.cursor, this.total });
}