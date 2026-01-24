import '../model/movie_model.dart';

abstract interface class MoviesRepo{

  Future<List<MovieModel>> getMoviesList(String? dateAdded, String? queryTerm,String? limit);
  Future<List<MovieModel>> getMoviesListByGenres(String genre);
  Future<String> getMoviesRating(String? movieId);
  String getErrorMessage();
  String getErrorStatusCode();
}