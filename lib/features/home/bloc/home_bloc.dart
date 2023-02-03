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
        super(HomeState.idle(favorites: localStorage.favorites.toSet())) {
    on<TapRecentSearch>(_tapRecentSearch);
    on<SubmitSearch>(_submitSearch);
    on<SetFocus>(_setFocus);
    on<ExitSearch>(_exitSearch);
    on<Favorite>(_favorite);
  }

  void _setFocus(SetFocus event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      hasKeyboardFocus: event.hasFocus,
      favorites: state.favorites,
      recentlySearched: state.recentlySearched,
    ));
  }

  void _exitSearch(ExitSearch event, Emitter<HomeState> emit) {
    _editingController.clear();
    emit(HomeState.idle(
      hasKeyboardFocus: state.hasKeyboardFocus,
      favorites: state.favorites,
      recentlySearched: state.recentlySearched,
    ));
  }

  Future<void> _tapRecentSearch(
    TapRecentSearch event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeState.searching(
      hasKeyboardFocus: state.hasKeyboardFocus,
      favorites: state.favorites,
      recentlySearched: state.recentlySearched,
    ));

    try {
      final SearchResultsResponse response =
          await _moviesRepository.resultsForTerm(term: event.term);

      emit(HomeState.viewingSearchResults(
        hasKeyboardFocus: state.hasKeyboardFocus,
        favorites: state.favorites,
        recentlySearched:
            {event.term, ...state.recentlySearched}.toList(growable: false),
        searchResults: response.search ?? [],
      ));
    } catch (e) {
      if (kDebugMode) {
        print('Failed to search $e');
      }

      emit(HomeState.searchFailed(
        hasKeyboardFocus: state.hasKeyboardFocus,
        favorites: state.favorites,
        recentlySearched: state.recentlySearched,
      ));
    }
  }

  Future<void> _submitSearch(
    SubmitSearch event,
    Emitter<HomeState> emit,
  ) async {
    if (_editingController.text.isEmpty) {
      emit(HomeState.idle(
        hasKeyboardFocus: state.hasKeyboardFocus,
        favorites: state.favorites,
        recentlySearched: state.recentlySearched,
      ));
      return;
    }

    emit(HomeState.searching(
      hasKeyboardFocus: state.hasKeyboardFocus,
      favorites: state.favorites,
      recentlySearched: state.recentlySearched,
    ));

    try {
      final SearchResultsResponse response =
          await _moviesRepository.resultsForTerm(term: _editingController.text);

      emit(HomeState.viewingSearchResults(
        hasKeyboardFocus: state.hasKeyboardFocus,
        favorites: state.favorites,
        recentlySearched: {_editingController.text, ...state.recentlySearched}
            .toList(growable: false),
        searchResults: response.search ?? [],
      ));
    } catch (e) {
      if (kDebugMode) {
        print('Failed to search $e');
      }

      emit(HomeState.searchFailed(
        hasKeyboardFocus: state.hasKeyboardFocus,
        favorites: state.favorites,
        recentlySearched: state.recentlySearched,
      ));
    }
  }

  Future<void> _favorite(Favorite event, Emitter<HomeState> emit) async {
    try {
      _localStorage.toggleFavorite(event.id);

      Set<String> favorites = {...state.favorites};
      if (state.favorites.contains(event.id)) {
        favorites.remove(event.id);
      } else {
        favorites.add(event.id);
      }

      emit(state.copyWith(favorites: favorites));
    } catch (e) {
      if (kDebugMode) {
        print('Failed to toggle favorite item $e');
      }

      emit(HomeState.searchFailed(
        hasKeyboardFocus: state.hasKeyboardFocus,
        favorites: state.favorites,
        recentlySearched: state.recentlySearched,
      ));
    }
  }
}
