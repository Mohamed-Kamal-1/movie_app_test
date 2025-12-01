import 'package:movie_app/api/model/movie_details/movie_details_response_dto.dart';

abstract interface class MovieDetailsRepo {
  Future<MovieDetailsResponseDto> getMovieDetails(String movieId);
}

