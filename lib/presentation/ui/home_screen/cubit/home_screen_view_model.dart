import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/api_result.dart';
import 'package:movie_app/domain/model/movie_model.dart';
import 'package:movie_app/domain/model/rating_model.dart';
import 'package:movie_app/presentation/ui/home_screen/cubit/hom_screen_state.dart';

import '../../../../domain/use_case/movies_list.dart';

@injectable
class HomeScreenViewModel extends Cubit<HomeScreenState> {
  MoviesListUseCase moviesListUseCase;
  HomeScreenViewModel(this.moviesListUseCase) : super(HomeInitialState());

  Future<void> getMoviesList(String dateAdded) async {
    emit(HomeLoadingState());
    Result<List<MovieModel>> response = await moviesListUseCase.getMoviesList(
        dateAdded: dateAdded, limit: '10');

    switch (response) {
      case Success<List<MovieModel>>():
        {
          emit(HomeSuccessState(moviesList: response.data));
        }

      case Failure<List<MovieModel>>():
        {
          emit(HomeErrorState(errorMessage: response.exception));
        }

    }
  }

  void moveAnotherTab(int index) {
    emit(MoveToAnotherTabState(index: index));
  }
}
