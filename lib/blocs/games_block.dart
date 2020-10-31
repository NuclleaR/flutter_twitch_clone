import 'dart:async';

import 'package:rxdart/subjects.dart';
import 'package:twitch_clone/models/models.dart';
import 'package:twitch_clone/responses/responses.dart';
import 'package:twitch_clone/services/services.dart';


class GameBloc {
  List<Game> _games = [];
  // Map<String, List<GameStream>>
  String _cursor;

  // Legacy data ======

  int _total = 0;
  int _limit = 30;
  int _offset = 0;

  // ==================
  final GameService _gameService = GameService();

  final _gamesFetcher = PublishSubject<List<Game>>();

  Stream<List<Game>> get games => _gamesFetcher.stream;

  StreamSink<List<Game>> get _sink => _gamesFetcher.sink;

  GameBloc();

  Future<void> fetchTopGames () async {
    Map<String, String> params = {
      // 'first': '50',
      'limit': _limit.toString(),
      'offset': _offset.toString(),
    };

    print('fetchTopGames');

    // if (_cursor != null) {
    //   params['after'] = _cursor;
    // }

    try {
      GamesResponse response = await _gameService.getGames(queryParameters: params);
      // TODO create infinity
      // _games = _games + response.list;
      _games = response.list;
      _sink.add(_games);
      // _cursor = response.cursor;
      _total = response.total;
    } catch (ex) {
      _sink.addError(ex);
      print(ex);
    }
  }

  void resetState() {
    _games = [];
    _cursor = null;
  }

  dispose() {
    _gamesFetcher.close();
  }
}