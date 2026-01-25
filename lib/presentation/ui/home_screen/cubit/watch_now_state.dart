import '../../../../domain/model/movie_model.dart';

abstract class WatchNowState {}

class WatchNowInitial extends WatchNowState {}

class WatchNowLoading extends WatchNowState {}

class WatchNowError extends WatchNowState {
  final Exception errorMessage;
  WatchNowError({required this.errorMessage});
}

class WatchNowSuccess extends WatchNowState {
  final List<MovieModel> moviesList;
  WatchNowSuccess({required this.moviesList});
}
