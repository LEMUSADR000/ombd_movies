part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.idle({
    @Default(false) bool hasKeyboardFocus,
    required Set<String> favorites,
    @Default([]) List<String> recentlySearched,
  }) = Idle;

  const factory HomeState.searching({
    @Default(false) bool hasKeyboardFocus,
    required Set<String> favorites,
    required List<String> recentlySearched,
  }) = Searching;

  const factory HomeState.viewingSearchResults({
    @Default(false) bool hasKeyboardFocus,
    required Set<String> favorites,
    required List<String> recentlySearched,
    required List<Search> searchResults,
  }) = ViewingSearchResults;

  const factory HomeState.searchFailed({
    @Default(false) bool hasKeyboardFocus,
    required Set<String> favorites,
    required List<String> recentlySearched,
  }) = SearchFailed;
}
