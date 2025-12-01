import 'package:movie_app/api/model/movie_details/movie_details_response_dto.dart';
import 'package:movie_app/api/model/movie_suggestion/movie_suggestion_response_dto.dart';
import 'package:movie_app/api/model/favourite/is_favourite_model.dart';

abstract class DetailsScreenState {}

class DetailsScreenInitialState extends DetailsScreenState {}

class DetailsScreenLoadingState extends DetailsScreenState {}

class DetailsScreenErrorState extends DetailsScreenState {
  String message;

  DetailsScreenErrorState({required this.message});
}

class DetailsAndSuggestionsSuccessState extends DetailsScreenState {
  final MovieDetailsResponseDto movieDetailsResponse;
  final MovieSuggestionResponseDto movieSuggestionResponse;

  DetailsAndSuggestionsSuccessState({
    required this.movieDetailsResponse,
    required this.movieSuggestionResponse,
  });
}

class IsFavouriteSuccessState extends DetailsScreenState {
  IsFavouriteModel isFavouriteModel;

  IsFavouriteSuccessState({required this.isFavouriteModel});
}

class IsFavouriteErrorState extends DetailsScreenState {
  String message;

  IsFavouriteErrorState({required this.message});
}

class AddToFavouriteSuccessState extends DetailsScreenState {
  String message;

  AddToFavouriteSuccessState({required this.message});
}

class AddToFavouriteErrorState extends DetailsScreenState {
  String message;

  AddToFavouriteErrorState({required this.message});
}

class RemoveFromFavouriteSuccessState extends DetailsScreenState {
  String message;

  RemoveFromFavouriteSuccessState({required this.message});
}

class RemoveFromFavouriteErrorState extends DetailsScreenState {
  String message;

  RemoveFromFavouriteErrorState({required this.message});
}

