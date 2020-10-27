

import 'cover_box.dart';

class Game {
  final int id;
  final int giantbombId;
  final String name;
  final CoverBox box;
  final CoverBox logo;
  final String localizedName;
  final String locale;

  final int viewers;
  final int channels;

  Game(
      {this.id,
      this.name,
      this.giantbombId,
      this.box,
      this.logo,
      this.localizedName,
      this.locale,
      this.viewers,
      this.channels});

  factory Game.fromJson(Map<String, dynamic> map) {
    Map game = map['game'];
    return Game(
      id: game['_id'],
      name: game['name'],
      giantbombId: game['giantbomb_id'],
      box: CoverBox.fromJson(game['box']),
      logo: CoverBox.fromJson(game['logo']),
      localizedName: game['localized_name'],
      locale: game['locale'],
      channels: map['channels'],
      viewers: map['viewers'],
    );
  }

  @override
  String toString() {
    return 'Game { id: $id, name: $name }';
  }
}
