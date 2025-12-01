import 'package:injectable/injectable.dart';
import 'package:movie_app/api/model/movie_details/movie_details_response_dto.dart';
import 'package:movie_app/domain/repos/movie_details_repo.dart';

@injectable
class MovieDetailsUseCase {
  final MovieDetailsRepo movieDetailsRepo;

  MovieDetailsUseCase(this.movieDetailsRepo);

  Future<MovieDetailsResponseDto> getMovieDetails(String movieId) async {
    return await movieDetailsRepo.getMovieDetails(movieId);
  }
}

