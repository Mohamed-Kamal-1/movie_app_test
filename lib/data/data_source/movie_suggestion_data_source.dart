import 'package:movie_app/api/model/movie_suggestion/movie_suggestion_response_dto.dart';

abstract interface class MovieSuggestionDataSource {
  Future<MovieSuggestionResponseDto> getMovieSuggestion(int movieId);
}

