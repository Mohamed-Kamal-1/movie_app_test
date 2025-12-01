import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/api/model/favourite/add_to_favourite_data_model.dart';
import 'package:movie_app/domain/use_case/favourite_use_case.dart';
import 'package:movie_app/domain/use_case/movie_details_use_case.dart';
import 'package:movie_app/domain/use_case/movie_suggestion_use_case.dart';
import 'package:movie_app/ui/details_screen/details_screen_state.dart';

@injectable
class DetailsScreenViewModel extends Cubit<DetailsScreenState> {
  final MovieDetailsUseCase movieDetailsUseCase;
  final MovieSuggestionUseCase movieSuggestionUseCase;
  final FavouriteUseCase favouriteUseCase;

  DetailsScreenViewModel(
    this.movieDetailsUseCase,
    this.movieSuggestionUseCase,
    this.favouriteUseCase,
  ) : super(DetailsScreenInitialState());

  Future<void> getMovieDetailsAndSuggestions(String movieId) async {
    try {
      emit(DetailsScreenLoadingState());

      final movieDetailsResponse = await movieDetailsUseCase.getMovieDetails(movieId);
      final movieSuggestionResponse = await movieSuggestionUseCase.getMovieSuggestion(movieId);

      if (movieDetailsResponse.status == "ok" &&
          movieSuggestionResponse.status == "ok") {
        emit(DetailsAndSuggestionsSuccessState(
          movieDetailsResponse: movieDetailsResponse,
          movieSuggestionResponse: movieSuggestionResponse,
        ));
      } else {
        emit(DetailsScreenErrorState(
          message: "Something went wrong",
        ));
      }
    } catch (e) {
      emit(DetailsScreenErrorState(message: e.toString()));
    }
  }

  Future<void> checkIsFavourite(String movieId) async {
    try {
      final result = await favouriteUseCase.isFavourite(movieId);
      if (result != null) {
        emit(IsFavouriteSuccessState(isFavouriteModel: result));
      } else {
        emit(IsFavouriteErrorState(message: "Failed to check favourite status"));
      }
    } catch (e) {
      emit(IsFavouriteErrorState(message: e.toString()));
    }
  }

  Future<void> addMovieToFavourite({
    required AddToFavouriteDataModel addFavouriteData,
  }) async {
    try {
      final result = await favouriteUseCase.addToFavourite(
        addFavouriteData: addFavouriteData,
      );
      if (result != null && result.statusCode == null) {
        emit(AddToFavouriteSuccessState(message: result.message ?? "Added to favourites"));
      } else {
        emit(AddToFavouriteErrorState(
          message: result?.message ?? "Failed to add to favourites",
        ));
      }
    } catch (e) {
      emit(AddToFavouriteErrorState(message: e.toString()));
    }
  }

  Future<void> removeFromFavourite(String movieId) async {
    try {
      final result = await favouriteUseCase.removeFromFavourite(movieId);
      if (result != null && result.statusCode == null) {
        emit(RemoveFromFavouriteSuccessState(
          message: result.message ?? "Removed from favourites",
        ));
      } else {
        emit(RemoveFromFavouriteErrorState(
          message: result?.message ?? "Failed to remove from favourites",
        ));
      }
    } catch (e) {
      emit(RemoveFromFavouriteErrorState(message: e.toString()));
    }
  }
}

