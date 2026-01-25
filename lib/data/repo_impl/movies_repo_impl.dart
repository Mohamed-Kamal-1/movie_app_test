import 'package:injectable/injectable.dart';
import 'package:movie_app/data/data_source/movies_list_data_source.dart';
import 'package:movie_app/domain/api_result.dart';
import 'package:movie_app/domain/model/movie_model.dart';
import 'package:movie_app/domain/model/rating_model.dart';

import '../../domain/repos/movies_repo.dart';

@Injectable(as: MoviesRepo)
class MoviesRepoImpl implements MoviesRepo {
  MoviesListDataSource moviesListDataSource;

  MoviesRepoImpl(this.moviesListDataSource);

  @override
  Future<Result<List<MovieModel>>> getMoviesList(String? dateAdded,String? queryTerm,String? limit) async {
    return await moviesListDataSource.getMoviesList(dateAdded,queryTerm,limit);
  }
  @override
  Future<Result<List<MovieModel>>> getMoviesListByGenres(String genre) async {
    return await moviesListDataSource.getMoviesListByGenres(genre);
  }




}
