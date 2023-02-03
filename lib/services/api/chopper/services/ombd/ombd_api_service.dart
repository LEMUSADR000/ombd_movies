import 'package:chopper/chopper.dart';

/// ASSUMPTION: API service is unlikely to be spoofed as generally these function
/// more as a black box dependency. However, if we were to perform integration
/// testing this could be used for this such case.
abstract class OmbdApiService {
  Future<Response> search({
    String? exactId,
    String? exactIshTitle,
    String? term,
  });
}
