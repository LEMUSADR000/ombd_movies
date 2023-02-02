import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_results.freezed.dart';
part 'search_results.g.dart';

@freezed
class SearchResultsResponse with _$SearchResultsResponse {
  @JsonSerializable(fieldRename: FieldRename.pascal)
  const factory SearchResultsResponse({
    List<Search>? search,
    String? totalResults,
    String? response,
  }) = _SearchResultsResponse;

  factory SearchResultsResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResultsResponseFromJson(json);
}

@freezed
class Search with _$Search {
  @JsonSerializable(fieldRename: FieldRename.pascal)
  const factory Search({
    @JsonKey(name: 'imdbID') required String imdbID,
    String? title,
    String? year,
    String? type,
    String? poster,
  }) = _Search;

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);
}

@freezed
class SearchResponse with _$SearchResponse {
  @JsonSerializable(fieldRename: FieldRename.pascal)
  const factory SearchResponse({
    @JsonKey(name: 'imdbID') required String imdbID,
    String? title,
    String? year,
    String? rated,
    String? released,
    String? runtime,
    String? genre,
    String? director,
    String? writer,
    String? actors,
    String? plot,
    String? language,
    String? country,
    String? awards,
    String? poster,
    List<Ratings>? ratings,
    String? metascore,
    @JsonKey(name: 'imdbRating') String? imdbRating,
    @JsonKey(name: 'imdbVotes') String? imdbVotes,
    String? type,
    String? dVD,
    String? boxOffice,
    String? production,
    String? website,
    String? response,
  }) = _SearchResponse;

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);
}

@freezed
class Ratings with _$Ratings {
  const factory Ratings({
    String? source,
    String? value,
  }) = _Ratings;

  factory Ratings.fromJson(Map<String, dynamic> json) =>
      _$RatingsFromJson(json);
}
