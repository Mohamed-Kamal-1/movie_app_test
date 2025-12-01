import 'package:injectable/injectable.dart';
import 'package:movie_app/api/model/movie_suggestion/movie_suggestion_response_dto.dart';
import 'package:movie_app/domain/repos/movie_suggestion_repo.dart';

@injectable
class MovieSuggestionUseCase {
  final MovieSuggestionRepo movieSuggestionRepo;

  MovieSuggestionUseCase(this.movieSuggestionRepo);

  Future<MovieSuggestionResponseDto> getMovieSuggestion(String movieId) async {
    return await movieSuggestionRepo.getMovieSuggestion(movieId);
  }
}

