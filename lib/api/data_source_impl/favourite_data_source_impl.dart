import 'package:injectable/injectable.dart';
import 'package:movie_app/api/api_manager.dart';
import 'package:movie_app/api/model/favourite/add_to_favourite_data_model.dart';
import 'package:movie_app/api/model/favourite/add_to_favourite_response_model.dart';
import 'package:movie_app/api/model/favourite/get_all_favourite_model.dart';
import 'package:movie_app/api/model/favourite/is_favourite_model.dart';
import 'package:movie_app/api/model/favourite/remove_from_favourite_model.dart';

import '../../data/data_source/favourite_data_source.dart';

@Injectable(as: FavouriteDataSource)
class FavouriteDataSourceImpl implements FavouriteDataSource {
  final ApiManager apiManager;

  FavouriteDataSourceImpl(this.apiManager);

  @override
  Future<AddToFavouriteResponseModel?> addToFavourite({
    required AddToFavouriteDataModel addFavouriteData,
  }) async {
    return await apiManager.addToFavourite(addFavouriteData: addFavouriteData);
  }

  @override
  Future<GetAllFavouriteModel?> getAllFavourite() async {
    return await apiManager.getAllFavourite();
  }

  @override
  Future<IsFavouriteModel?> isFavourite(String movieId) async {
    return await apiManager.isFavourite(movieId);
  }

  @override
  Future<RemoveFromFavouriteModel?> removeFromFavourite(String movieId) async {
    return await apiManager.removeFromFavourite(movieId);
  }
}

