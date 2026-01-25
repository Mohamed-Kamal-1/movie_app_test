part of 'browse_cubit.dart';

abstract class BrowseState {}

class BrowseLoading extends BrowseState {}

class BrowseError extends BrowseState {
  final Exception errorMessage;

  // BrowseError(this.message, {required this.exceptionMessage});
  BrowseError({required this.errorMessage});
}

class BrowseSuccess extends BrowseState {
  final List<MovieModel> movies;
  final List<String> genres;
  final String selectedGenre;

  BrowseSuccess({
    required this.movies,
    required this.genres,
    required this.selectedGenre,
  });
}
