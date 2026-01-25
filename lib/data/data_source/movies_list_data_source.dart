import 'package:movie_app/domain/api_result.dart';
import 'package:movie_app/domain/model/movie_model.dart';

abstract interface class MoviesListDataSource {
  Future<Result<List<MovieModel>>> getMoviesList(String? dateAdded, String? queryTerm,String? limit);
  Future<Result<List<MovieModel>>> getMoviesListByGenres(String genre);
  String getErrorMessage();

  String getErrorStatusCode();

}
