import 'package:get_it/get_it.dart';
import 'package:ombd_movies/features/home/bloc/home_bloc.dart';
import 'package:ombd_movies/features/movie_loader/bloc/movies_loader_bloc.dart';
import 'package:ombd_movies/services/api/chopper/clients/ombd/ombd_client.dart';
import 'package:ombd_movies/services/api/chopper/clients/ombd/ombd_client_impl.dart';
import 'package:ombd_movies/services/api/chopper/services/ombd/ombd_api_service.dart';
import 'package:ombd_movies/services/api/chopper/services/ombd/ombd_api_service_impl.dart';
import 'package:ombd_movies/services/api/repositories/movies_repository/movies_repository.dart';
import 'package:ombd_movies/services/api/repositories/movies_repository/movies_repository_impl.dart';
import 'package:ombd_movies/services/local/storage/storage.dart';
import 'package:ombd_movies/services/local/storage/storage_impl.dart';
import 'package:ombd_movies/utility/config.dart';

final GetIt getIt = GetIt.instance;

extension GetItExtension on GetIt {
  /// ASSUMPTION: Initialization of services needs knowledge of some config
  /// information for knowing if we are in prod, staging, dev env

  void init({required Config config}) {
    getIt
      /* Global */
      ..registerSingletonAsync<LocalStorage>(
        () async {
          final LocalStorage localStorage = LocalStorageImpl();
          await localStorage.init();
          return localStorage;
        },
      )

      /* BLoCs */
      ..registerFactory<HomeBloc>(
        () => HomeBloc(
          moviesRepository: getIt(),
          localStorage: getIt(),
        ),
      )
      ..registerFactory<MovieLoaderBloc>(
        () => MovieLoaderBloc(
          moviesRepository: getIt(),
        ),
      )

      /* Services */
      ..registerLazySingleton<MoviesRepository>(
        () => MoviesRepositoryImpl(ombdApiService: getIt()),
      )
      ..registerSingleton<OmbdClient>(
        OmbdClientImpl.withServices(
          config: config,
          services: [OmbdApiServiceImpl.create()],
        ),
      )
      ..registerFactory<OmbdApiService>(
        () => getIt<OmbdClient>().getService<OmbdApiServiceImpl>(),
      );
  }
}
