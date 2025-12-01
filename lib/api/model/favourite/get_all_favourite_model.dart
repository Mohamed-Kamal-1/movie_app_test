import 'favourite_movie_model.dart';

class GetAllFavouriteModel {
  GetAllFavouriteModel({
    this.data,
    this.message,
    this.statusCode,
  });

  GetAllFavouriteModel.fromJson(dynamic json) {
    message = json['message'];
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(FavouriteMovieModel.fromJson(v));
      });
    }
  }

  List<FavouriteMovieModel>? data;
  String? message;
  num? statusCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['statusCode'] = statusCode;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

