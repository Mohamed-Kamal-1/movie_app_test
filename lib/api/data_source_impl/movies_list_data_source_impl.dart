import 'package:injectable/injectable.dart';
import 'package:movie_app/api/api_manager.dart';
import 'package:movie_app/api/execute_api.dart';
import 'package:movie_app/domain/api_result.dart';
import 'package:movie_app/domain/model/movie_model.dart';

import '../../data/data_source/movies_list_data_source.dart';
import '../model/movie_list/movie_response_dto.dart';

@Injectable(as: MoviesListDataSource)
class MoviesListDataSourceImpl implements MoviesListDataSource {
  ApiManager apiManager;
  String? errorMessage;
  String? statusCode;

  MoviesListDataSourceImpl(this.apiManager);

  @override
  Future<Result<List<MovieModel>>> getMoviesList(String? dateAdded,
      String? queryTerm,
      String? limit) async {
    return executeApi(() async {
      MovieResponseDto response = await apiManager.getMoviesList(
          dateAdded: dateAdded ?? 'date_added',
          queryTerm: queryTerm ?? '0',
          limit: limit ?? '20');
      return response.data?.movies
          ?.map((moviesDto) => moviesDto.getMoviesList())
          .toList() ??
          [];
    },);

  }

  @override
  String getErrorMessage() {
    return errorMessage ?? 'not Found';
  }

  @override
  String getErrorStatusCode() {
    return statusCode!;
  }


  @override
  Future<Result<List<MovieModel>>> getMoviesListByGenres(String genre) async {
    return executeApi(() async{
      MovieResponseDto response = await apiManager.getMoviesListByGenres(genre);
      response.statusMessage = errorMessage;
      response.code = statusCode;
      return response.data?.movies
          ?.map((moviesDto) => moviesDto.getMoviesList())
          .toList() ??
          [];
    },);

  }

}
