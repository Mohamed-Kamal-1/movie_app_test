import 'package:movie_app/domain/model/rating_model.dart';

class RatingDto {
  RatingDto({
      this.id,
      this.url,
      this.averageRating, 
      this.numVotes,});

  RatingDto.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    averageRating = json['averageRating'];
    numVotes = json['numVotes'];
  }
  String? id;
  String? url;
  num? averageRating;
  num? numVotes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['averageRating'] = averageRating;
    map['numVotes'] = numVotes;
    return map;
  }

  RatingModel convertToRating() {
    return RatingModel(
      url: url,
      id: id,
      averageRating: averageRating,
    );
  }
}