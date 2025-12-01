import 'package:injectable/injectable.dart';
import 'package:movie_app/api/model/favourite/add_to_favourite_data_model.dart';
import 'package:movie_app/api/model/favourite/add_to_favourite_response_model.dart';
import 'package:movie_app/api/model/favourite/get_all_favourite_model.dart';
import 'package:movie_app/api/model/favourite/is_favourite_model.dart';
import 'package:movie_app/api/model/favourite/remove_from_favourite_model.dart';
import 'package:movie_app/data/data_source/favourite_data_source.dart';

import '../../domain/repos/favourite_repo.dart';

@Injectable(as: FavouriteRepo)
class FavouriteRepoImpl implements FavouriteRepo {
  final FavouriteDataSource favouriteDataSource;

  FavouriteRepoImpl(this.favouriteDataSource);

  @override
  Future<AddToFavouriteResponseModel?> addToFavourite({
    required AddToFavouriteDataModel addFavouriteData,
  }) {
    return favouriteDataSource.addToFavourite(addFavouriteData: addFavouriteData);
  }

  @override
  Future<GetAllFavouriteModel?> getAllFavourite() {
    return favouriteDataSource.getAllFavourite();
  }

  @override
  Future<IsFavouriteModel?> isFavourite(String movieId) {
    return favouriteDataSource.isFavourite(movieId);
  }

  @override
  Future<RemoveFromFavouriteModel?> removeFromFavourite(String movieId) {
    return favouriteDataSource.removeFromFavourite(movieId);
  }
}

