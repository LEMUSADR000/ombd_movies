part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.search() = Search;
  const factory HomeEvent.exitSearch() = ExitSearch;
  const factory HomeEvent.favorite({required String id}) = Favorite;
}
