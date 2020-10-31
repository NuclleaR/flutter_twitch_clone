import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {
  @JsonKey(name: 'tag_id')
  final String tagId;

  @JsonKey(name: 'is_auto')
  final bool isAuto;

  @JsonKey(name: 'localization_names')
  final Map<String, String> localizationNames;

  Tag({this.tagId, this.localizationNames, this.isAuto});

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);

  String get name => localizationNames['ru-ru'];

  String getLocalName(String locale) {
    return localizationNames[locale];
  }
}
