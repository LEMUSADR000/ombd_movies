import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ombd_movies/services/api/repositories/models/search_results.dart';
import 'package:ombd_movies/services/api/repositories/movies_repository/movies_repository.dart';

part 'movies_loader_bloc.freezed.dart';
part 'movies_loader_event.dart';
part 'movies_loader_state.dart';

class MovieLoaderBloc extends Bloc<MovieLoaderEvent, MovieLoaderState> {
  final MoviesRepository _moviesRepository;

  MovieLoaderBloc({required MoviesRepository moviesRepository})
      : _moviesRepository = moviesRepository,
        super(const MovieLoaderState.loading()) {
    on<Load>(_load);
  }

  Future<void> _load(Load event, Emitter<MovieLoaderState> emit) async {
    try {
      final SearchResponse searchResponse =
          await _moviesRepository.searchById(id: event.id);
      emit(MovieLoaderState.loaded(search: searchResponse));
    } catch (e) {
      emit(MovieLoaderState.failed(search: state.search));
    }
  }
}
