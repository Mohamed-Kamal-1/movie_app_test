import 'package:movie_app/domain/api_result.dart';

import '../model/movie_model.dart';

abstract interface class MoviesRepo{

  Future<Result<List<MovieModel>>> getMoviesList(String? dateAdded,
      String? queryTerm, String? limit);
  Future<Result<List<MovieModel>>> getMoviesListByGenres(String genre);

}