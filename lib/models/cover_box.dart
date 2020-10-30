import 'package:json_annotation/json_annotation.dart';

part 'cover_box.g.dart';

@JsonSerializable()
class CoverBox {
  final String large;
  final String medium;
  final String small;
  final String template;

  CoverBox({this.large, this.medium, this.small, this.template});

  factory CoverBox.fromJson(Map<String, dynamic> json) => _$CoverBoxFromJson(json);

  Map<String, dynamic> toJson() => _$CoverBoxToJson(this);
}