import 'movie_suggestion_data_dto.dart';
import '../movie_list/meta_dto.dart';

class MovieSuggestionResponseDto {
  MovieSuggestionResponseDto({
    this.status,
    this.statusMessage,
    this.data,
    this.meta,
  });

  MovieSuggestionResponseDto.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null
        ? MovieSuggestionDataDto.fromJson(json['data'])
        : null;
    meta = json['@meta'] != null ? Meta.fromJson(json['@meta']) : null;
  }

  String? status;
  String? statusMessage;
  MovieSuggestionDataDto? data;
  Meta? meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (meta != null) {
      map['@meta'] = meta?.toJson();
    }
    return map;
  }
}

