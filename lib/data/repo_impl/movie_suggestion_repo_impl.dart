import 'package:injectable/injectable.dart';
import 'package:movie_app/api/model/movie_suggestion/movie_suggestion_response_dto.dart';
import 'package:movie_app/data/data_source/movie_suggestion_data_source.dart';

import '../../domain/repos/movie_suggestion_repo.dart';

@Injectable(as: MovieSuggestionRepo)
class MovieSuggestionRepoImpl implements MovieSuggestionRepo {
  final MovieSuggestionDataSource movieSuggestionDataSource;

  MovieSuggestionRepoImpl(this.movieSuggestionDataSource);

  @override
  Future<MovieSuggestionResponseDto> getMovieSuggestion(String movieId) {
    return movieSuggestionDataSource.getMovieSuggestion(movieId);
  }
}

