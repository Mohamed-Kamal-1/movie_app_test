import 'movie_details_dto.dart';

class MovieDetailsDataDto {
  MovieDetailsDataDto({this.movie});

  MovieDetailsDataDto.fromJson(dynamic json) {
    movie = json['movie'] != null ? MovieDetailsDto.fromJson(json['movie']) : null;
  }

  MovieDetailsDto? movie;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (movie != null) {
      map['movie'] = movie?.toJson();
    }
    return map;
  }
}

