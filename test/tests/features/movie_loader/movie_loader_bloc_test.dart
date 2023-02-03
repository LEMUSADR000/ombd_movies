import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ombd_movies/features/movie_loader/bloc/movies_loader_bloc.dart';
import 'package:ombd_movies/services/api/repositories/models/search_results.dart';
import 'package:ombd_movies/services/api/repositories/movies_repository/movies_repository.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {}

void main() {
  MovieLoaderBloc? bloc;
  MoviesRepository? moviesRepository;

  setUp(() {
    moviesRepository = MockMoviesRepository();

    bloc = MovieLoaderBloc(moviesRepository: moviesRepository!);
  });

  tearDown(() {
    bloc?.close();
    bloc = null;
    moviesRepository = null;
  });

  group('MovieLoaderBloc', () {
    blocTest(
      'initial state correct',
      build: () => bloc!,
      expect: () => [],
    );

    blocTest(
      'loading film success state',
      build: () {
        when(() => moviesRepository!.searchById(id: 'id')).thenAnswer(
            (invocation) => Future.value(const SearchResponse(imdbID: 'mock')));

        return bloc!..add(const MovieLoaderEvent.load('id'));
      },
      expect: () => [
        isInstanceOf<Loaded>(),
      ],
    );

    blocTest(
      'loading film error state',
      build: () {
        when(() => moviesRepository!.searchById(id: 'id'))
            .thenThrow((invocation) => Exception('mock exception'));

        return bloc!..add(const MovieLoaderEvent.load('id'));
      },
      expect: () => [
        isInstanceOf<Failed>(),
      ],
    );
  });
}
