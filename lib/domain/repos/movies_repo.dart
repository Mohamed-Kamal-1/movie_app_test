import '../model/movie_model.dart';

abstract interface class MoviesRepo{

  Future<List<MovieModel>> getMoviesList(String? dateAdded, String? queryTerm,String? limit);
  Future<List<MovieModel>> getMoviesListByGenres(String genre);
  String getErrorMessage();
  String getErrorStatusCode();
}