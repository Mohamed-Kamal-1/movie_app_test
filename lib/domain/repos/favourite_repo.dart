import 'package:movie_app/api/model/favourite/add_to_favourite_data_model.dart';
import 'package:movie_app/api/model/favourite/add_to_favourite_response_model.dart';
import 'package:movie_app/api/model/favourite/get_all_favourite_model.dart';
import 'package:movie_app/api/model/favourite/is_favourite_model.dart';
import 'package:movie_app/api/model/favourite/remove_from_favourite_model.dart';

abstract interface class FavouriteRepo {
  Future<AddToFavouriteResponseModel?> addToFavourite({
    required AddToFavouriteDataModel addFavouriteData,
  });

  Future<GetAllFavouriteModel?> getAllFavourite();

  Future<IsFavouriteModel?> isFavourite(String movieId);

  Future<RemoveFromFavouriteModel?> removeFromFavourite(String movieId);
}

