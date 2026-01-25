import 'package:movie_app/domain/model/movie_model.dart';

abstract class HomeScreenState {}

class HomeInitialState extends HomeScreenState {}

class HomeLoadingState extends HomeScreenState {}

class HomeErrorState extends HomeScreenState {
  Exception errorMessage;

  HomeErrorState({required this.errorMessage});
}

class HomeSuccessState extends HomeScreenState {
  List<MovieModel>? moviesList;

  // List<String>

  HomeSuccessState({this.moviesList});
}

class MoveToAnotherTabState extends HomeScreenState {
  final int? index;

  MoveToAnotherTabState({this.index});
}

// class RatingState extends HomeScreenState {
//   final String? id;
//   final String? url;
//   final num? rate;
//
//   RatingState({this.id, this.url, this.rate});
// }

