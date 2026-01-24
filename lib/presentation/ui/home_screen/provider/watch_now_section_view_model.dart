import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/domain/model/movie_model.dart';

import '../../../../domain/use_case/movies_list.dart';
@injectable
class WatchNowSectionViewModel extends ChangeNotifier {
  MoviesListUseCase moviesListUseCase;

  WatchNowSectionViewModel(this.moviesListUseCase);

  WatchNowSectionState state = WatchNowSectionState();

  void _sendState(WatchNowSectionState newState) {
    state = newState;
    notifyListeners();
  }
}

enum ScreenState { initial, Loading, Success, Error }

class WatchNowSectionState {
  ScreenState state = ScreenState.initial;

  List<MovieModel>? movies;

  String? loadingMessage;
  String? errorMessage;

  WatchNowSectionState({
    this.state = ScreenState.initial,
    this.movies,
    this.loadingMessage,
    this.errorMessage,
  });
}
