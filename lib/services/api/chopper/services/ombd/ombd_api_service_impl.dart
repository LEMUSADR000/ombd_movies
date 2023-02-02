import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:ombd_movies/services/api/chopper/services/ombd/ombd_api_service.dart';

part 'ombd_api_service_impl.chopper.dart';

@ChopperApi(baseUrl: '')
abstract class OmbdApiServiceImpl extends ChopperService
    implements OmbdApiService {
  @override
  @Post(path: '')
  Future<Response> search({
    @Query('i') String? exactId,
    @Query('t') String? exactIshTitle,
    @Query('s') String? term,
  });

  static OmbdApiServiceImpl create([ChopperClient? client]) {
    return _$OmbdApiServiceImpl(client);
  }
}
