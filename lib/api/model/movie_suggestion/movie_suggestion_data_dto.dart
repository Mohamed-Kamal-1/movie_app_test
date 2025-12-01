import '../movie_list/movies_dto.dart';

class MovieSuggestionDataDto {
  MovieSuggestionDataDto({
    this.movieCount,
    this.movies,
  });

  MovieSuggestionDataDto.fromJson(dynamic json) {
    movieCount = json['movie_count'];
    if (json['movies'] != null) {
      movies = [];
      json['movies'].forEach((v) {
        movies?.add(MoviesDto.fromJson(v));
      });
    }
  }

  num? movieCount;
  List<MoviesDto>? movies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movie_count'] = movieCount;
    if (movies != null) {
      map['movies'] = movies?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

