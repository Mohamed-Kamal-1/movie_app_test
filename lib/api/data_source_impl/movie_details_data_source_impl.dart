import 'package:injectable/injectable.dart';
import 'package:movie_app/api/api_manager.dart';
import 'package:movie_app/api/model/movie_details/movie_details_response_dto.dart';

import '../../data/data_source/movie_details_data_source.dart';

@Injectable(as: MovieDetailsDataSource)
class MovieDetailsDataSourceImpl implements MovieDetailsDataSource {
  final ApiManager apiManager;

  MovieDetailsDataSourceImpl(this.apiManager);

  @override
  Future<MovieDetailsResponseDto> getMovieDetails(String movieId) async {
    return await apiManager.getMovieDetails(movieId);
  }
}

