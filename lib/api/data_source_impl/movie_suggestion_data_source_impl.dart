import 'package:injectable/injectable.dart';
import 'package:movie_app/api/api_manager.dart';
import 'package:movie_app/api/model/movie_suggestion/movie_suggestion_response_dto.dart';

import '../../data/data_source/movie_suggestion_data_source.dart';

@Injectable(as: MovieSuggestionDataSource)
class MovieSuggestionDataSourceImpl implements MovieSuggestionDataSource {
  final ApiManager apiManager;

  MovieSuggestionDataSourceImpl(this.apiManager);

  @override
  Future<MovieSuggestionResponseDto> getMovieSuggestion(String movieId) async {
    return await apiManager.getMovieSuggestion(movieId);
  }
}

