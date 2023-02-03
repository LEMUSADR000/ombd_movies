import 'package:chopper/chopper.dart';
import 'package:ombd_movies/services/api/chopper/clients/ombd/ombd_client.dart';
import 'package:ombd_movies/utility/config.dart';

class OmbdClientImpl implements OmbdClient {
  final ChopperClient client;

  OmbdClientImpl._(this.client);

  @override
  ServiceType getService<ServiceType extends ChopperService>() =>
      client.getService<ServiceType>();

  factory OmbdClientImpl.withServices({
    required Config config,
    required Iterable<ChopperService> services,
  }) {
    final ChopperClient client = ChopperClient(
      baseUrl: Uri.parse(config.ombdBaseUrl),
      services: services,
      interceptors: [(req) => _addQueryParameter(req, config)],
    );

    return OmbdClientImpl._(client);
  }

  /// ASSUMPTION: Current config contains our token, but in a sign-on-enabled
  /// application we would actually eagerly load a token from some form of
  /// secure storage, and then use this value instead of pulling from our config
  static Request _addQueryParameter(Request req, Config config) {
    final params = Map<String, dynamic>.from(req.parameters);
    params['apikey'] = config.token;

    return req.copyWith(parameters: params);
  }
}
