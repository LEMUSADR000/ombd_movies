part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.idle({
    required Set<String> favorites,
    @Default([]) List<String> recentlyViewed,
  }) = Idle;

  const factory HomeState.searching({
    required Set<String> favorites,
    required List<String> recentlyViewed,
  }) = Searching;

  const factory HomeState.viewingSearchResults({
    required Set<String> favorites,
    required List<String> recentlyViewed,
    required List<String> searchResults,
  }) = ViewingSearchResults;

  const factory HomeState.searchFailed({
    required Set<String> favorites,
    required List<String> recentlyViewed,
  }) = SearchFailed;
}
