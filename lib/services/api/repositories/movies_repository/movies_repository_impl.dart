import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:ombd_movies/services/api/chopper/services/ombd/ombd_api_service.dart';
import 'package:ombd_movies/services/api/repositories/models/search_results.dart';
import 'package:ombd_movies/services/api/repositories/movies_repository/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final OmbdApiService _ombdApiService;

  MoviesRepositoryImpl({required OmbdApiService ombdApiService})
      : _ombdApiService = ombdApiService;

  @override
  Future<SearchResponse> searchById({required String id}) async {
    if (_results.containsKey(id)) {
      return _results[id]!;
    }

    return _searchHelper({'id': id});
  }

  @override
  Future<SearchResponse> searchByTitle({required String title}) {
    return _searchHelper({'title': title});
  }

  @override
  Future<SearchResultsResponse> resultsForTerm({required String term}) async {
    final Response response = await _ombdApiService.search(term: term);

    SearchResultsResponse results;
    if (response.isSuccessful && response.body != null) {
      try {
        results = SearchResultsResponse.fromJson(jsonDecode(response.body));
      } catch (e) {
        throw Exception('Failed to parse BlocksAllResponse $e');
      }
    } else {
      throw Exception('SearchResultsResponse data response invalid');
    }

    return results;
  }

  /// HELPERS

  Future<SearchResponse> _searchHelper(
    Map<String, dynamic> params,
  ) async {
    final Response response = await _ombdApiService.search(
      exactIshTitle: params['title'],
      exactId: params['id'],
      term: params['s'],
    );

    SearchResponse searchResponse;
    if (response.isSuccessful && response.body != null) {
      try {
        searchResponse = SearchResponse.fromJson(jsonDecode(response.body));
      } catch (e) {
        throw Exception('Failed to parse BlocksAllResponse $e');
      }
    } else {
      throw Exception('SearchResultsResponse data response invalid');
    }

    _results[searchResponse.imdbID] = searchResponse;

    return searchResponse;
  }

  @override
  Map<String, SearchResponse> get results => _results;
  final Map<String, SearchResponse> _results = {};
}
