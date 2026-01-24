import 'package:movie_app/domain/model/movie_model.dart';


abstract interface class MoviesListDataSource {
  Future<List<MovieModel>> getMoviesList(String? dateAdded, String? queryTerm,String? limit);
  Future<List<MovieModel>> getMoviesListByGenres(String genre);

  Future<String> getMoviesRating(String? movieId);
  String getErrorMessage();

  String getErrorStatusCode();

}
