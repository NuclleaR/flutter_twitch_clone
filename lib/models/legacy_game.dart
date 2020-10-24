class _CoverBox {
  final String large;
  final String medium;
  final String small;
  final String template;

  _CoverBox({this.large, this.medium, this.small, this.template});

  factory _CoverBox.fromMap(Map<String, dynamic> map) {
    return _CoverBox(
        large: map['large'],
        medium: map['medium'],
        small: map['small'],
        template: map['template']);
  }
}

class Game {
  final int id;
  final int giantbombId;
  final String name;
  final _CoverBox box;
  final _CoverBox logo;
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
      box: _CoverBox.fromMap(game['box']),
      logo: _CoverBox.fromMap(game['logo']),
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
