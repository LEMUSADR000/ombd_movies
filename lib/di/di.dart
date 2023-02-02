import 'package:get_it/get_it.dart';
import 'package:ombd_movies/services/api/chopper/clients/ombd/ombd_client.dart';
import 'package:ombd_movies/services/api/chopper/clients/ombd/ombd_client_impl.dart';
import 'package:ombd_movies/services/api/chopper/services/ombd/ombd_api_service_impl.dart';
import 'package:ombd_movies/utility/config.dart';

final GetIt getIt = GetIt.instance;

extension GetItExtension on GetIt {
  void init({required Config config}) {
    /* API Services */
    getIt.registerSingleton<OmbdClient>(
      OmbdClientImpl.withServices(
        config: config,
        services: [OmbdApiServiceImpl.create()],
      ),
    );
  }
}
