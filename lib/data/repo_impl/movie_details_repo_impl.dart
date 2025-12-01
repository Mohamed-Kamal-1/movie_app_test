import 'package:injectable/injectable.dart';
import 'package:movie_app/api/model/movie_details/movie_details_response_dto.dart';
import 'package:movie_app/data/data_source/movie_details_data_source.dart';

import '../../domain/repos/movie_details_repo.dart';

@Injectable(as: MovieDetailsRepo)
class MovieDetailsRepoImpl implements MovieDetailsRepo {
  final MovieDetailsDataSource movieDetailsDataSource;

  MovieDetailsRepoImpl(this.movieDetailsDataSource);

  @override
  Future<MovieDetailsResponseDto> getMovieDetails(String movieId) {
    return movieDetailsDataSource.getMovieDetails(movieId);
  }
}

