import 'package:ombd_movies/services/api/repositories/models/search_results.dart';

/// ASSUMPTION: Movies repository will be stubbed in unit tests, or for development
/// purposed when we need to spoof data
abstract class MoviesRepository {
  Future<SearchResponse> searchByTitle({required String title});
  Future<SearchResponse> searchById({required String id});
  Future<SearchResultsResponse> resultsForTerm({required String term});

  Map<String, SearchResponse> get results;
}
