import 'movie_details_data_dto.dart';

class MovieDetailsResponseDto {
  MovieDetailsResponseDto({
    this.status,
    this.statusMessage,
    this.data,
    this.code,
  });

  MovieDetailsResponseDto.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? MovieDetailsDataDto.fromJson(json['data']) : null;
  }

  String? status;
  String? statusMessage;
  String? code;
  MovieDetailsDataDto? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

