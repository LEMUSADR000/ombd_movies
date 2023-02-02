import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:ombd_movies/services/api/chopper/services/ombd/ombd_api_service.dart';

part 'ombd_api_service_impl.chopper.dart';

@ChopperApi(baseUrl: '')
abstract class OmbdApiServiceImpl extends ChopperService
    implements OmbdApiService {
  @override
  @Get(path: '')
  Future<Response> fetchMovies();

  @override
  @Post(path: '')
  Future<Response> search();

  static OmbdApiServiceImpl create([ChopperClient? client]) {
    return _$OmbdApiServiceImpl(client);
  }
}
