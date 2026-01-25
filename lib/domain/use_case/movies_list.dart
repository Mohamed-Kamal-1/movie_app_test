import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/api_result.dart';
import 'package:movie_app/domain/repos/movies_repo.dart';

import '../model/movie_model.dart';
import '../model/rating_model.dart';

@injectable
class MoviesListUseCase {
  MoviesRepo moviesRepo;

  MoviesListUseCase(this.moviesRepo);

  Future<Result<List<MovieModel>>> getMoviesList({String? dateAdded = 'date_added', String? queryTerm = '0',String? limit = '20'}) {
    return moviesRepo.getMoviesList(dateAdded,queryTerm,limit);
  }
  Future<Result<List<MovieModel>>> getMoviesListByGenres(String genre) async {
    return await moviesRepo.getMoviesListByGenres(genre);
  }



}
