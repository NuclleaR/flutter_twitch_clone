import 'package:json_annotation/json_annotation.dart';

import 'cover_box.dart';

part 'legacy_game.g.dart';

@JsonSerializable()
class Game {
  @JsonKey(name: '_id')
  final int id;
  @JsonKey(name: 'giantbomb_id')
  final int giantbombId;
  final String name;
  final CoverBox box;
  final CoverBox logo;
  @JsonKey(name: 'localized_name')
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

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);

  @override
  String toString() {
    return 'Game { id: $id, name: $name }';
  }
}
