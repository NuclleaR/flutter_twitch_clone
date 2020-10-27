import 'dart:async';

import 'package:rxdart/subjects.dart';
import 'package:twitch_clone/models/models.dart';
import 'package:twitch_clone/responses/responses.dart';
import 'package:twitch_clone/services/services.dart';

class StreamsBloc {
  List<GameStream> _streams = [];
  String _cursor;

  final StreamsService _streamsService = StreamsService();
  final _streamsFetcher = PublishSubject<List<GameStream>>();

  Stream<List<GameStream>> get streams => _streamsFetcher.stream;

  StreamSink<List<GameStream>> get _sink => _streamsFetcher.sink;

  Future<void> fetchStreams(int gameId) async {
    Map<String, String> params = {
      'game_id': gameId.toString(),
      'first': '50',
      'language': 'ru',
      // 'after': _cursor,
    };
    try {
      StreamsResponse response = await _streamsService.getGameStreams(params);
      _streams = response.list;
      _sink.add(_streams);
      _cursor = response.cursor;
    } catch (ex) {
      _sink.addError(ex);
      print(ex);
    }

  }

  void resetState() {
    _streams = [];
    _cursor = null;
  }

  dispose() {
    _streamsFetcher.close();
  }
}