import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/presentation/ui/home_screen/cubit/watch_now_state.dart';

import '../../../../domain/api_result.dart';
import '../../../../domain/model/movie_model.dart';
import '../../../../domain/use_case/movies_list.dart';
@injectable
class WatchNowViewModel extends Cubit<WatchNowState> {
  final MoviesListUseCase moviesUseCase;

  WatchNowViewModel(this.moviesUseCase) : super(WatchNowInitial());

  Future<void> getMoviesListByGenres(String genre) async {
    emit(WatchNowLoading());
    Result<List<MovieModel>> response = await moviesUseCase
        .getMoviesListByGenres(genre);

    switch (response) {
      case Success<List<MovieModel>>():
        {
          emit(WatchNowSuccess(moviesList: response.data));
        }

      case Failure<List<MovieModel>>():
        {
          emit(WatchNowError(errorMessage: response.exception));
        }
    }
  }
}
