part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.tapSearch() = TapSearch;
  const factory HomeEvent.setFocus(bool hasFocus) = SetFocus;
  const factory HomeEvent.exitSearch() = ExitSearch;
  const factory HomeEvent.favorite({required String id}) = Favorite;
  const factory HomeEvent.tapRecentSearch({required String term}) =
      TapRecentSearch;
}
