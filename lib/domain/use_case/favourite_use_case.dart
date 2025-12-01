import 'package:injectable/injectable.dart';
import 'package:movie_app/api/model/favourite/add_to_favourite_data_model.dart';
import 'package:movie_app/api/model/favourite/add_to_favourite_response_model.dart';
import 'package:movie_app/api/model/favourite/get_all_favourite_model.dart';
import 'package:movie_app/api/model/favourite/is_favourite_model.dart';
import 'package:movie_app/api/model/favourite/remove_from_favourite_model.dart';
import 'package:movie_app/domain/repos/favourite_repo.dart';

@injectable
class FavouriteUseCase {
  final FavouriteRepo favouriteRepo;

  FavouriteUseCase(this.favouriteRepo);

  Future<AddToFavouriteResponseModel?> addToFavourite({
    required AddToFavouriteDataModel addFavouriteData,
  }) async {
    return await favouriteRepo.addToFavourite(addFavouriteData: addFavouriteData);
  }

  Future<GetAllFavouriteModel?> getAllFavourite() async {
    return await favouriteRepo.getAllFavourite();
  }

  Future<IsFavouriteModel?> isFavourite(String movieId) async {
    return await favouriteRepo.isFavourite(movieId);
  }

  Future<RemoveFromFavouriteModel?> removeFromFavourite(String movieId) async {
    return await favouriteRepo.removeFromFavourite(movieId);
  }
}

