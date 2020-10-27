class CoverBox {
  final String large;
  final String medium;
  final String small;
  final String template;

  CoverBox({this.large, this.medium, this.small, this.template});

  factory CoverBox.fromJson(Map<String, dynamic> map) {
    return CoverBox(
        large: map['large'],
        medium: map['medium'],
        small: map['small'],
        template: map['template']);
  }
}