class CastDto {
  CastDto({
    this.name,
    this.characterName,
    this.urlSmallImage,
  });

  CastDto.fromJson(dynamic json) {
    name = json['name'];
    characterName = json['character_name'];
    urlSmallImage = json['url_small_image'];
  }

  String? name;
  String? characterName;
  String? urlSmallImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['character_name'] = characterName;
    map['url_small_image'] = urlSmallImage;
    return map;
  }
}

