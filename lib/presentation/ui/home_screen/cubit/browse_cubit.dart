import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/api_result.dart';
import 'package:movie_app/domain/model/movie_model.dart';

import '../../../../domain/use_case/movies_list.dart';

part 'browse_state.dart';

@injectable
class BrowseCubit extends Cubit<BrowseState> {
  final MoviesListUseCase moviesListUseCase;

  List<MovieModel> allMovies = [];
  List<MovieModel> filteredMovies = [];
  List<String> genres = ["All"];

  BrowseCubit(this.moviesListUseCase) : super(BrowseLoading());

  Future<void> loadMovies() async {
    emit(BrowseLoading());


    Result<List<MovieModel>> response = await moviesListUseCase.getMoviesList(
        dateAdded: "2025");


    switch (response) {
      case Success<List<MovieModel>>():
          allMovies = response.data;
          _extractGenres();
          filteredMovies = List.from(allMovies);
        {
          emit(BrowseSuccess(movies: filteredMovies, genres: genres,
            selectedGenre: "All",));
        }

      case Failure<List<MovieModel>>():
        {
          emit(BrowseError(errorMessage: response.exception));
        }
    }




  }


  void _extractGenres() {
    genres = ["All"];

    for (var m in allMovies) {
      if (m.genres != null) {
        genres.addAll(m.genres!);
      }
    }

    genres = genres.toSet().toList();
  }

  void filterByGenre(String selected) {
    if (selected == "All") {
      filteredMovies = List.from(allMovies);
    } else {
      filteredMovies = allMovies
          .where((m) => m.genres != null && m.genres!.contains(selected))
          .toList();
    }

    emit(BrowseSuccess(
      movies: filteredMovies,
      genres: genres,
      selectedGenre: selected,
    ));
  }

  Future<void> searchMovies(String title) async {
    emit(BrowseLoading());


    Result<List<MovieModel>> response = await moviesListUseCase.getMoviesList(
        queryTerm: title);


    switch (response) {
      case Success<List<MovieModel>>():
        {
          filteredMovies = response.data;
          emit(BrowseSuccess(
            movies: filteredMovies,
            genres: genres,
            selectedGenre: "All",
          ));
        }
      case Failure<List<MovieModel>>():
        {
          BrowseError(errorMessage: response.exception);
        }
    }

  }
}
