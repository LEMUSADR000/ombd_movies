import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ombd_movies/features/home/bloc/home_bloc.dart';
import 'package:ombd_movies/services/api/repositories/movies_repository/movies_repository.dart';
import 'package:ombd_movies/services/local/storage/storage.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {}

class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  HomeBloc? bloc;
  MoviesRepository? moviesRepository;
  LocalStorage? storage;

  setUp(() {
    moviesRepository = MockMoviesRepository();
    storage = MockLocalStorage();

    when(() => storage!.favorites).thenReturn([]);

    bloc = HomeBloc(
      moviesRepository: moviesRepository!,
      localStorage: storage!,
    );
  });

  tearDown(() {
    bloc?.close();
    bloc = null;
    moviesRepository = null;
    storage = null;
  });

  group('HomeBloc', () {
    blocTest(
      'initial state correct',
      build: () => bloc!,
      expect: () => [],
    );

    blocTest(
      'focus toggling',
      build: () {
        return bloc!
          ..add(const HomeEvent.setFocus(true))
          ..add(const HomeEvent.setFocus(false));
      },
      expect: () => [
        isA<HomeState>().having(
          (p0) => p0.hasKeyboardFocus,
          'hasKeyboardFocus',
          true,
        ),
        isA<HomeState>().having(
          (p0) => p0.hasKeyboardFocus,
          'hasKeyboardFocus',
          false,
        ),
      ],
    );

    blocTest(
      'exit search',
      build: () {
        return bloc!..add(const HomeEvent.exitSearch());
      },
      expect: () => [
        isInstanceOf<Idle>(),
      ],
    );
  });
}
