import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ombd_movies/services/api/repositories/models/search_results.dart';
import 'package:ombd_movies/services/api/repositories/movies_repository/movies_repository.dart';
import 'package:ombd_movies/services/local/storage/storage.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MoviesRepository _moviesRepository;
  final LocalStorage _localStorage;

  final TextEditingController _editingController = TextEditingController();
  TextEditingController get editingController => _editingController;

  HomeBloc({
    required MoviesRepository moviesRepository,
    required LocalStorage localStorage,
  })  : _moviesRepository = moviesRepository,
        _localStorage = localStorage,
        super(HomeState.idle(favorites: localStorage.favorites)) {
    on<Search>(_search);
    on<ExitSearch>(_exitSearch);
    on<Favorite>(_favorite);
  }

  Future<void> _exitSearch(ExitSearch event, Emitter<HomeState> emit) async {
    emit(HomeState.idle(
      favorites: state.favorites,
      recentlyViewed: state.recentlyViewed,
    ));
  }

  Future<void> _search(Search event, Emitter<HomeState> emit) async {
    emit(HomeState.searching(
      favorites: state.favorites,
      recentlyViewed: state.recentlyViewed,
    ));

    try {
      if (_editingController.text.isEmpty) {
        _editingController.clear();
        return;
      }

      final SearchResultsResponse response =
          await _moviesRepository.resultsForTerm(term: _editingController.text);
      final List<String> searchKeys = (response.search ?? [])
          .map((e) => e.title ?? 'N/A')
          .toList(growable: false);

      emit(HomeState.viewingSearchResults(
        favorites: state.favorites,
        recentlyViewed: state.recentlyViewed,
        searchResults: searchKeys,
      ));
    } catch (e) {
      if (kDebugMode) {
        print('Failed to search $e');
      }

      emit(HomeState.searchFailed(
        favorites: state.favorites,
        recentlyViewed: state.recentlyViewed,
      ));
    }
  }

  Future<void> _favorite(Favorite event, Emitter<HomeState> emit) async {
    try {
      await _localStorage.toggleFavorite(event.id);
      emit(state.copyWith(favorites: _localStorage.favorites));
    } catch (e) {
      if (kDebugMode) {
        print('Failed to toggle favorite item $e');
      }

      emit(HomeState.searchFailed(
        favorites: state.favorites,
        recentlyViewed: state.recentlyViewed,
      ));
    }
  }
}
