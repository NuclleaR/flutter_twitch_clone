import 'dart:async';

import 'package:rxdart/subjects.dart';
import 'package:twitch_clone/models/models.dart';
import 'package:twitch_clone/responses/responses.dart';
import 'package:twitch_clone/services/services.dart';

class StreamsBloc {
  List<GameStream> _streams = [];
  String _cursor;
  int _total;

  Map<String, Tag> _tags = {};

  final StreamsService _streamsService = StreamsService();

  final _streamsFetcher = PublishSubject<List<GameStream>>();

  Stream<List<GameStream>> get streams => _streamsFetcher.stream;
  StreamSink<List<GameStream>> _streamsSink;

  StreamsBloc() {
    _streamsSink = _streamsFetcher.sink;
    // _tagsSink = _tagsFetcher.sink;
  }

  Future<void> fetchStreams(Game game) async {
    Map<String, String> params = {
      'game_id': game.id.toString(),
      'first': '50',
      'language': 'ru',
      // 'after': _cursor,
    };
    try {
      StreamsResponse response = await _streamsService.getGameStreams(params);
      _streams = response.list
          .map((GameStreamData data) {
            return GameStream.fromData(data, response.tags, response.users[data.userId]);
          }).toList();

      _tags = response.tags;
      _streamsSink.add(_streams);
      _cursor = response.cursor;
      _total = response.total;
    } catch (ex) {
      _streamsSink.addError(ex);
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
