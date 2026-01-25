import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/api_result.dart';
import 'package:movie_app/domain/model/movie_model.dart';
import 'package:movie_app/presentation/ui/home_screen/tabs/search_tab/cubit/search_screen_state.dart';

import '../../../../../../domain/use_case/movies_list.dart';

@injectable
class SearchScreenViewModel extends Cubit<SearchScreenState> {
  MoviesListUseCase moviesListUseCase;
  String? _lastQuery;

  SearchScreenViewModel(this.moviesListUseCase) : super(SearchInitialState());

  Future<void> getMoviesListByTitle(String title) async {
    _lastQuery = title;
    if (title.isEmpty) {
      emit(SearchEmptyState(isEmpty: true));
      return;
    }
      emit(SearchLoadingState());
    Result<List<MovieModel>> response = await moviesListUseCase.getMoviesList(
        queryTerm: _lastQuery);

      if (_lastQuery != title) return;

    switch (response) {
      case Success<List<MovieModel>>():
        {
          emit(SearchSuccessState(moviesList: response.data));
        }

      case Failure<List<MovieModel>>():
        {
          emit(SearchErrorState(errorMessage: response.exception));
        }
    }


  }
}
