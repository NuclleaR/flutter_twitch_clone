class Game {
  final String id;
  final String name;
  final String boxArtUrl;

  Game(this.id, this.name, this.boxArtUrl);

  Game.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        boxArtUrl = map['box_art_url'];
}
